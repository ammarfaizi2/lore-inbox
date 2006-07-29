Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWG2XPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWG2XPq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 19:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWG2XPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 19:15:46 -0400
Received: from mail.tmr.com ([64.65.253.246]:1460 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1750750AbWG2XPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 19:15:45 -0400
Message-ID: <44CBECF0.4080702@tmr.com>
Date: Sat, 29 Jul 2006 19:19:12 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Hua Zhong <hzhong@gmail.com>
CC: "'Pavel Machek'" <pavel@ucw.cz>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: suspend2 merge history [was Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
References: <200607292319.31935.rjw@sisk.pl> <005701c6b359$dacc6f50$0200a8c0@nuitysystems.com>
In-Reply-To: <005701c6b359$dacc6f50$0200a8c0@nuitysystems.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:
>> Moreover, if the swsusp's resume doesn't work for you and 
>> suspend2's resume does, this probably means that suspend2 
>> contains some driver fixes that haven't been submitted for merging.
> 
> This statement worries me for several reasons.
> 
> First, I've seen repeatedly blame for "drivers". People might buy it if there was not a working suspend2. I never saw Nigal blame
> drivers; instead he makes sure to provide working code. In the end, users want a working suspend, and that's what counts.
> 
> Second, if the current swsusp maintainers have genuine interest for the users (not just "it works on my machine"), I would think
> they'd have taken a serious look at why suspend2 has a higher success rate. But from the above comment, you are not even sure why
> that is, and could only speculate "this probably means (drivers)". I could hardly be convinced that the current maintainers have
> been trying to work with Nigal to improve Linux suspend.
> 
> At last, "maintainer" is not just a title or a feeling of superiority, it's a responsibility of providing a great system to the
> users. I'll just quote Linus when he was flaming suspend-to-ram a couple of months ago. Replace it with suspend-to-disk at your own
> will:
> 
> "The fact that worries me is that suspend-to-ram DOES NOT WORK FOR PEOPLE. 
> I have never _ever_ met a laptop or machine of mine that "just worked". 
> I've always had to fix something, and people always end up having to do 
> something ridiculous like unlink all modules etc.
> 
> If that isn't what worries you, you're on the wrong page."
> 
> http://article.gmane.org/gmane.linux.power-management.general/2105

That's the way I feel, I'm glad someone who can't be ignored feels the 
same way. There is always a reason why the working version can't be put 
in mainline, there's always a reason why it doesn't work on my machines 
but I'm assured that it works on {someone}'s machine so I must have a 
bad {bios|setup|partition table|attitude}.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
