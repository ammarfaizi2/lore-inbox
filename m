Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAZNWZ>; Fri, 26 Jan 2001 08:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAZNWP>; Fri, 26 Jan 2001 08:22:15 -0500
Received: from APastourelles-101-1-2-119.abo.wanadoo.fr ([193.251.53.119]:3332
	"HELO dark.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S129143AbRAZNWG>; Fri, 26 Jan 2001 08:22:06 -0500
To: Miles Lane <miles@megapathdsl.net>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Running "make install" runs lilo on my Athlon but not my Pentium II.
In-Reply-To: <200101222202.f0MM24s01811@flint.arm.linux.org.uk>
	<3A713E8F.131C6589@megapathdsl.net>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 26 Jan 2001 14:21:36 +0100
In-Reply-To: <3A713E8F.131C6589@megapathdsl.net>
Message-ID: <m3itn2e9en.fsf@dark.mandrakesoft.com>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane <miles@megapathdsl.net> writes:

> Yes.  The script exists on both machines, but I think you have
> nailed the problem.  The working machine is running RedHat 6.2 plus
> a 2.4.0+ kernel.  The other (the Athlon) is running Mandrake 7.2 plus
> a 2.4.0+ kernel.  On the working machine, the installkernel script
> is just a shell script.  While, on the problem machine, the script
> is a PERL script written by chmouel@mandrakesoft.com.  
> So, Chmouel, what gives?  Can you help me debug this?

this installkernel script try to detect what kind of bootloader you
have on your machine (since we ship GRUB and LILO), what the output of
:

/usr/sbin/detectloader

give you (under the mdk machine).

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
