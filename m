Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130481AbRBCA4t>; Fri, 2 Feb 2001 19:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130724AbRBCA4a>; Fri, 2 Feb 2001 19:56:30 -0500
Received: from mail-ffm-p.arcor-ip.de ([145.253.2.10]:55274 "EHLO
	mail.arcor-ip.de") by vger.kernel.org with ESMTP id <S130481AbRBCA41>;
	Fri, 2 Feb 2001 19:56:27 -0500
Date: Fri, 2 Feb 2001 08:11:53 +0100
From: Stefan Frank <sfr@gmx.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Keyboard Scancode Problems
Message-ID: <20010202081153.A460@obelix.gallien.de>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3A78AFAF.82FCB4F2@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <3A78AFAF.82FCB4F2@Hell.WH8.TU-Dresden.De>; from sorisor@Hell.WH8.TU-Dresden.De on Thu, Feb 01, 2001 at 01:37:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Udo!

On Thu, 01 Feb 2001, Udo A. Steinberg wrote:

> 
> Hi all,
> 
> With all the latest kernels (at least since 2.4.0-test12)
> I have had occasional problems with a PS/2 keyboard when
> switching back and forth between X and text consoles.
> 
> In most cases the problem occurs when switching from X to
> a text console, which renders the keyboard totally unusable.
> Pressing any key results in ^W ^E and other garbage.
> Sometimes pressing Ctrl fixes the problem, other times not
> even SysRq works.
> 
> The kernel logs the following stuff:
> 
> keyboard: unrecognized scancode (70) - ignored
> keyboard: unrecognized scancode (66) - ignored
> keyboard: unknown scancode e0 71
> keyboard: unknown scancode e0 70
> 
> and so forth. I cannot reliably reproduce it though.
> 
> Can someone enlighten me whether this is a keyboard problem,
> X problem or something wrong with the kernel's console stuff?
> 

I had the same problem when upgrading from 2.4.0-test10 to 2.4.0,
altough my keyboard worked for about half a year without problems. 
But, what a coincidence, it turned out to be a hardware problem. Two pins
of the PS/2 connector were moved inside the connector, thus they didn't
connect to the keyboard controller. I replaced the keyboard cable and
all is well. Did you try to replace the keyboard ?

Regards, Stefan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
