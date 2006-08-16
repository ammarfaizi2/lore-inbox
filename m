Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWHPN7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWHPN7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWHPN7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:59:46 -0400
Received: from bay0-omc2-s19.bay0.hotmail.com ([65.54.246.155]:46226 "EHLO
	bay0-omc2-s19.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1750760AbWHPN7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:59:45 -0400
Message-ID: <BAY114-F135E5B07856A5191B7A119FA4C0@phx.gbl>
X-Originating-IP: [193.62.3.251]
X-Originating-Email: [lukesharkey@hotmail.co.uk]
In-Reply-To: <d120d5000608151010m3ee6c33fi4a41b41007b1ff69@mail.gmail.com>
From: "Luke Sharkey" <lukesharkey@hotmail.co.uk>
To: dmitry.torokhov@gmail.com
Cc: andi@rhlx01.fht-esslingen.de, davej@redhat.com, gene.heskett@verizon.net,
       ian.stirling@mauve.plus.com, linux-kernel@vger.kernel.org,
       malattia@linux.it, lista1@comhem.se
Subject: Re: Touchpad problems with latest kernels
Date: Wed, 16 Aug 2006 14:59:40 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 16 Aug 2006 13:59:40.0983 (UTC) FILETIME=[38166C70:01C6C13C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

>Ok, there seems to be two distinct issues here. 1) Synaptics
>'supersensitive' mode, 2) pointer 'freezing'.
Hmmm... perhaps "jerky" was the wrong choice of word.  I don't at all mean 
I've had a supersensitive touchpad: quite the opposite.  What I was trying 
to convey was the fact that when my pointer freezes, sometimes it becomes 
unfrozen again suddenly (for a brief time) and then moves forward a little, 
then gets stuck again, and in this way is "jerky".  So not supersensitivity. 
  (Apologies for any confusion).

>The trick is to have a terminal open and then do alt-tab (presuming that it 
>does not unfreeze the pointer)

Yes, I've been doing that as a worthwhile precaution.  Sometimes the pointer 
seems to get so stuck even when I plug in a normal mouse, it remains frozen. 
  Seeing as Linux is less easily controlled with the keyboard compared to 
MS-Windows, sometimes all I can do is Alt-tab to the terminal window and do 
a command line reboot.

(Off topic question: why not have the K menu open when the "MS-Windows" 
button on the keyboard is pressed, as happens with the "Start" button on 
MS-windows?)

*However*, I have noticed that sometimes when I alt-tab between any windows 
/ programs I have open, sometimes the pointer becomes unstuck again...

>Also, is there programs that poll status of your battery or monitor box's 
>temperature?

Battery charge level, yes, but not the box's temperature.  I have tried lots 
of apps to try and do this, e.g. gkrellm, but there is no support for this 
on my laptop.  Besides, these problems often evidence themselves soon after 
I switch on, so I don't think laptop temperature would still be a problem 
that early.  Also, I rip the occasional DVD, sometimes leaving my computer 
on for 5+ hours: it doesn't overheat.

>Oh, another one... try booting with "ec_intr=0" on the kernel command line 
>to disable embedded controller interrupt mode.

>And finally, can I mples get a dmesg (or /var/log/messages) of boot with 
>"i8042.debug=1 log_buf_len=131072" please?

Thank you for the suggestions.  I will try the kernel option, and post the 
results of the error log.

Yours,
LS

_________________________________________________________________
Be the first to hear what's new at MSN - sign up to our free newsletters! 
http://www.msn.co.uk/newsletters

