Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUDFRLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUDFRLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:11:53 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:35769 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261158AbUDFRLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:11:52 -0400
Message-ID: <4072E4B8.2070102@colorfullife.com>
Date: Tue, 06 Apr 2004 19:11:20 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Nielsen <a.nielsen@optushome.com.au>
CC: Francois Romieu <romieu@fr.zoreil.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
References: <406EA054.2020401@colorfullife.com>	<20040404105558.2bffd4f0.malvineous@optushome.com.au>	<20040404111513.A3165@electric-eye.fr.zoreil.com> <20040406075142.147a0e4c.a.nielsen@optushome.com.au>
In-Reply-To: <20040406075142.147a0e4c.a.nielsen@optushome.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Nielsen wrote:

>>Can you send the unpatched r8169.o module ?
>>    
>>
>
>Here is the compiled source file (r8169.c -> r8169.o) from 2.6.5-rc1
>(which had the same problem and has an identical .c file) but I'm not
>sure if it's different to the final module so please let me know if you
>wanted something else:
>
>http://members.optushome.com.au/a.nielsen/r8169.o.bz2  (66 kB)
>  
>
Thanks. The code reloads the tx ring value from memory, thus I don't 
understand why it deadlocks.

--
    Manfred

