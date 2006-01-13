Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422692AbWAMOW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422692AbWAMOW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 09:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422694AbWAMOW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 09:22:57 -0500
Received: from relay4.usu.ru ([194.226.235.39]:2986 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1422692AbWAMOW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 09:22:56 -0500
Message-ID: <43C7B7F4.2060204@ums.usu.ru>
Date: Fri, 13 Jan 2006 19:23:48 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       dmitry.torokhov@gmail.com
Subject: Re: linux-2.6.15-git7: PS/2 keyboard dies on ppp traffic
References: <43C66E82.4030106@ums.usu.ru>	<20060112224301.74b8875f.akpm@osdl.org>	<1137150613.4419.0.camel@localhost.localdomain> <20060113030850.7ff5a505.akpm@osdl.org>
In-Reply-To: <20060113030850.7ff5a505.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.0.27; VDF: 6.33.0.121; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>  
>
>>On Iau, 2006-01-12 at 22:43 -0800, Andrew Morton wrote:
>>    
>>
>>>> infinitely replicated several last packets. events/0 consumes all the 
>>>> CPU. tty buffering revamping patch is the obvious candidate, but I 
>>>> haven't tried to revert it yet.
>>>>        
>>>>
>>>Darn, I hadn't thought of that.  Yes tty-revamp might be the culprit.
>>>      
>>>
>>That sounds like the bug that Paul fixed.
>>
>>    
>>
>
>That means "please test 2.6.15-git10" ;)
>  
>
Paul's fix is actually in 2.6.15-git9. This version seems to work 
(downloaded 20x more data than usually required to trigger the bug).

Thanks.

-- 
Alexander E. Patrakov
