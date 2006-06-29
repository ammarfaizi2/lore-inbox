Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWF2PFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWF2PFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWF2PFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:05:46 -0400
Received: from mail.tmr.com ([64.65.253.246]:26050 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1750773AbWF2PFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:05:45 -0400
Message-ID: <44A3ECE0.10104@tmr.com>
Date: Thu, 29 Jun 2006 11:08:16 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: radeonfb: corrupted screen on bootup
References: <200606282118.27750.mb@bu3sch.de>
In-Reply-To: <200606282118.27750.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> Hi,
> 
> I have a weird error with my PowerBook G4, which
> has a radeon card. I am using radeonfb.

I had a similar problem, and solved it by using the "wrong" (aty128fb) 
module which makes me happy. Booted working 5-6 times now, which is a 
few weeks since I run for long periods.

> After bootup, the screen sometimes looks like it is melting.
> I made a video to show you what is going on:
> http://bu3sch.de/misc/after_boot.avi  (6.1 MB)
> 
> It does only happen sometimes. I could not find
> a way to reproduce it.
> If I start X after boot with a melting screen, X is also
> melting:
> http://bu3sch.de/misc/after_x_switch.avi  (6.6 MB)
> 
> But here comes the interresting part:
> If I switch back into the console, the screen becomes
> normal again and I can continue to work as usual.
> 
> I am suspecting some initialization routine bug.
> It never happened when booting into OSX.
> 
> In X I use the "radeon" driver.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

