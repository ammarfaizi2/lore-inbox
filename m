Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267150AbRGJVng>; Tue, 10 Jul 2001 17:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267151AbRGJVn0>; Tue, 10 Jul 2001 17:43:26 -0400
Received: from mta13-acc.tin.it ([212.216.176.44]:9692 "EHLO fep13-svc.tin.it")
	by vger.kernel.org with ESMTP id <S267150AbRGJVnO>;
	Tue, 10 Jul 2001 17:43:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Antonio Pagliaro <antoniopagliaro@tin.it>
Reply-To: antoniopagliaro@tin.it
Organization: LiLa
To: linux-kernel@vger.kernel.org
Subject: Athlon Thunderbird, Abit KT7 Raid, Kernel 2.4: DESKTOP FROZEN!
Date: Tue, 10 Jul 2001 23:39:20 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01071023392004.02550@lila.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My box: Athlon Thunderbird 900 MHz, MotherboardAbit KT7 Raid, 
Kernel 2.4 (the one that comes with Red Hat 7.1 no updates) 

I get apparently random desktop freezing.

Last time:

I was just doing nothing so the screensaver
was on when I noticed the screen was frozen. Nor the keyboard
neither the mouse worked. No combination of CTRL-ALT keys.
Only choice left: reset. I did it.  When it booted again I got a

Kernel Panic: Attempted to kill the idle task
In idle: not syncing.

(by the way: what is the SysRq magic or something similar?
Does it help? Which keys??)

This time I had to unplug the computer. After 5 minutes I tried again.
In many trials I got hundreds of errors. These:

-After checking /root (passed), it stopped checking /home (failed)
and trying to repair it with fsck gave no result (when the computer
tried to reboot, it freezes again)

-After checking both /root and /home (passed), it stopped at sshd
saying: /etc/rc.d/rc line 117 951 segmentation fault  $i start

-At the end of the startup, black screen and message:
Id "x" respawning too fast disabled for 5 minutes (and waiting
produces the same message again: I had to unplug)

-Inside KDE, trying to open anything gave an error related to
inode and in a few seconds X was disabled again for 5 minutes.

Since somebody tells me the Oops is important, I noticed that
when this appeared it was 0002. If this helps..

After a couple of hours I tried and I was succesfull. Now it seems
to be everything ok.

Anyway, a desktop freezing happens every now and again and
no ctrl-alt-anything combination works. Just reset.
This is very dangerous, and even if so far the fsck was always ok,
I feel my data are at high risk this way.

At Red Hat support I got this suggestion:
>Since you are using KDE, there has been a few bugs in terms of memory hole
>that
>have been fixed.  You can check them out and apply the updtes to your
>machine
>and we'll see if that could the problem.
>
>http://www.redhat.com/support/errata/RHSA-2001-059.html

Is this really a KDE problem? I myself doubt...
It could be a kernel problem or maybe hardware (I checked
all the ram and removed one, but freezing is still there)

Thanks for any help, I am in trouble!!

Antonio

