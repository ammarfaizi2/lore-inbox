Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVGYL6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVGYL6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 07:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVGYL6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 07:58:32 -0400
Received: from [195.23.16.24] ([195.23.16.24]:10895 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261169AbVGYL6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 07:58:32 -0400
Message-ID: <42E4D3E3.9010304@grupopie.com>
Date: Mon, 25 Jul 2005 12:58:27 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
Cc: Tom Marshall <tmarshall@real.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: itimer oddness in 2.6.12
References: <20050722171657.GG4311@real.com> <42E14735.1090205@grupopie.com> <20050722205825.GB6476@real.com> <42E1A208.8060408@mvista.com>
In-Reply-To: <42E1A208.8060408@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Tom Marshall wrote:
>> On Fri, Jul 22, 2005 at 08:21:25PM +0100, Paulo Marques wrote:
>>>[...]
>>> Unfortunately, this is not so clear cut as it seems :(
> 
> Oops!  That patch is wrong.  The +1 should be applied to the initial 
> interval _only_.  We KNOW when the repeating intervals start (i.e. at 
> the jiffie edge) and don't need to adjust them.  The patch, however, 
> incorrectly, rolls them all into one.  The attach patch should fix the 
> problem.  Warnning, it compiles and boots, but I have not tested it.

Yes, this seems to be the Right Thing :)

Acked-by: Paulo Marques <pmarques@grupopie.com>

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
