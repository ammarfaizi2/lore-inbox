Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUG0WPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUG0WPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266660AbUG0WPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:15:16 -0400
Received: from mail.tmr.com ([216.238.38.203]:12812 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266648AbUG0WPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:15:09 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: New dev model (was [PATCH] delete devfs)
Date: Tue, 27 Jul 2004 18:18:05 -0400
Organization: TMR Associates, Inc
Message-ID: <ce6jr1$ifj$1@gatekeeper.tmr.com>
References: <Pine.GSO.4.58.0407231652050.9434@waterleaf.sonytel.be> <20040723155045.19770.qmail@web52906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Trace: gatekeeper.tmr.com 1090966177 18931 192.168.12.100 (27 Jul 2004 22:09:37 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <20040723155045.19770.qmail@web52906.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

szonyi calin wrote:
> --- Geert Uytterhoeven <geert@linux-m68k.org> a écrit : > On
> Fri, 23 Jul 2004, [iso-8859-1] szonyi calin wrote:
> 
>>>And with new devepment model this expenses will be passed to
>>
>>the
>>
>>>end user when the kernel will not be stable enough and will
>>> crash. Do you you remember the 8k vs 4k stack problem for
>>>Nvidia binary kernel module ?
>>
>>You want a stable kernel, but you also want to rely on
>>binary-only kernel
>>modules?
>>
> 
> 
> No. I wasn't clear on that one. My example was wrong. AFAIK the
> 8k/4k stack kernel problem were causing problems for other 
> people too.
> 
> 
>>The Linux kernel people cannot guarantee stability with
>>binary-only kernel
>>modules. And the Linux kernel people cannot solve that
>>problem...
>>
> 
> 
> I underestand that. 
> However hpa told me that the stability of the 2.6 kernel will 
> not suffer.

And akpm posted that he intended to remove cryptoloop, while others are 
calling for the end to devfs. Not having features disappear is part of 
stable, I would think, not just "not oops more often."

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
