Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277165AbRKYOwP>; Sun, 25 Nov 2001 09:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275973AbRKYOvz>; Sun, 25 Nov 2001 09:51:55 -0500
Received: from [212.18.232.186] ([212.18.232.186]:6919 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S277165AbRKYOvn>; Sun, 25 Nov 2001 09:51:43 -0500
Date: Sun, 25 Nov 2001 14:51:35 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
Message-ID: <20011125145134.B23807@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva> <20011125143449.B5506@duron.intern.kubla.de> <tgadxagbjn.fsf@mercury.rus.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <tgadxagbjn.fsf@mercury.rus.uni-stuttgart.de>; from Florian.Weimer@RUS.Uni-Stuttgart.DE on Sun, Nov 25, 2001 at 03:39:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 03:39:08PM +0100, Florian Weimer wrote:
> BTW, what is the correct recovery strategy, assuming 2.4.15 has not
> been rebooted yet?  Installing a fixed kernel is obviously the first
> step.  How should one reboot the system to minimize damage?  Use a
> normal system shutdown (with the -F parameter to forc fsck on next
> boot), or go to single user, "touch /forcefsck", sync, wait a minute,
> and switching of power?

>From Viro's mail (on http://lwn.net/daily/2.4.15-recovery.php3):

| IOW, if you are running 2.4.15 - build a patched kernel, install it and
| do the following:
|	* switch to single-user
|	* sync
|	* umount everything non-buys
|	* remount the rest read-only
|	* turn the thing off
|	* boot with patched kernel or with anything before 2.4.15-pre9

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

