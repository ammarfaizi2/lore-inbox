Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132488AbRDNRiq>; Sat, 14 Apr 2001 13:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132493AbRDNRig>; Sat, 14 Apr 2001 13:38:36 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:7865 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132488AbRDNRi0>; Sat, 14 Apr 2001 13:38:26 -0400
Date: Sat, 14 Apr 2001 18:38:25 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
cc: linux-kernel@vger.kernel.org
Subject: CML2 1.1.0 bug and snailspeed
In-Reply-To: <002601c0c4fb$c7e54260$0201a8c0@home>
Message-ID: <Pine.SOL.3.96.1010414174944.810A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I tried the CML2 1.1.0. (Had to spend hours installing Python
2.0 until I found all required configure options and got the right modules 
compiled in, but ok, that's a one off and is not CML2's fault, also ran
make test to make sure it works.)

Installed cml, cwd to kernel, and ran make menuconfig.

Waited about 2-5 minutes (didn't time it) to get the menu. Slower than
CML1 by a bit. [Note: My development machine is a Pentium Classic 133S
with 64MiB ECC RAM and ATA-100 7200RPM HD on Promise ATA-100 controller
with several network cards, runs like a charm with 2.4 kernel for what it
is used for: file serving/ftp serving/smb serving/nat]

In the menu the colour scheme is a bit strange but everyone has a
different taste. Would need some getting used to, but ok. It does seem
like a step back in time though, compared to the old menuconfig which had
nice windows feel and colours, IMHO. I am not sure why it had to be
changed. Surely you can have the old interface with the new theorem
prover?

I found a bug: In "Intel and compatible 80x86 processor options", "Intel
and compatible 80x86 processor types" I press "y" on "Pentium Classic"
option and it activates Penitum-III as well as Pentium Classic options at
the same time!?! Tried to play around switching to something else and then
onto Pentium Classic again and it enabled Pentium Classic and Pentium
Pro/Celeron/Pentium II (NEW) this time! Something is very wrong here.

Now a general comment: CML2 is extremely slow to the point of not being
usable! )-: It would take me hours to configure a kernel with this.  Just
pressing "n"/"y" or "m" somewhere takes easily several seconds to
complete... Pressing any of the arrow keys takes between 1 (up/down) and
10 (left/right) seconds to complete. *Argh!* When a window is up, saying
press any key to continue there are delays of several seconds of nothing
happening at all before the window disappers. 

With this slow response time, I wonder whether I actually pressed the key
so press it again, key gets queued, so it gets executed when the first key
press has finished executing wreaking havoc. )-: It might be all cool and
good having a theorem prover and what not inside the configuration but if
this is going to replace CML1 completely, IMHO, you will _have_ to provide
some speedy way of configuration (and no, using "vi .config" or equivalent
is not an option I would like to use...). Many people have been commenting
that speed doesn't matter "just use a newer computer" but that argument is
just stupid IMNSHO. That's what MS says when they release a new
OS/program... I don't need a new computer, this one works absolutely fine
and maxes out all it's 10Mbit network connections quite happily, so why
should I buy something faster?!? Just to configure a kernel? Surely not.
Linux has always been the OS of choice for people with a small budget and
the way it is going it is running the danger of loosing this corner of
this rather big market.

I will be back to CML1 now so I can configure and kick off the compile
of this kernel before dinner...

Best regards,

	Anton

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

