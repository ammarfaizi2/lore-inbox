Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292842AbSB0UCR>; Wed, 27 Feb 2002 15:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292920AbSB0UB7>; Wed, 27 Feb 2002 15:01:59 -0500
Received: from web21301.mail.yahoo.com ([216.136.173.212]:10684 "HELO
	web21301.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292900AbSB0UBh>; Wed, 27 Feb 2002 15:01:37 -0500
Message-ID: <20020227200127.58784.qmail@web21301.mail.yahoo.com>
Date: Wed, 27 Feb 2002 12:01:26 -0800 (PST)
From: bridgette <nbeditlnxchik@yahoo.com>
Subject: Re: Possible IDE related crash on 2.4.18-rc4?
To: Jeff Lessem <Jeff.Lessem@Colorado.EDU>, linux-kernel@vger.kernel.org
In-Reply-To: <200202271753.KAA37749@ibg.colorado.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Jeff Lessem <Jeff.Lessem@Colorado.EDU> wrote:
> I am having what seems to be some sort of IDE
> related crash when I run
> 2.4.18-rc4.  The computer is a Dell Inspiron 5000e
> laptop, which is a
> PIII 600, 384MB ram, Intel PIIX4 IDE controller
> (440BX), and an
> IBM-DJSA-230 30GB laptop disk.  The disk is
> partitioned into reiserfs
> (29GB) and swap (386MB).
> 
> The machine will appear to work fine, but then the
> disk will spindown
> and immediately restart, then the drive light stays
> on and the machine
> is hung solid.  It will not respond to SysRq, or
> anything other than
> holding the power button down until it turns off. 
> The last time the
> disk restarted I noticed that it made similar
> seeking noises to what
> it makes when being powered on.  It is NOT crashing
> when making that
> IBM click-boing noise.
> 
> Obviously this may be a hardware related problem,
> but IBM's drive
> fitness test reports the drive to be OK, and I have
> not had the
> problem when using kernels <= 2.4.17 (even after
> observing the problem
> with 2.4.18).  No IDE errors appear in the log
> before the crash.
> 
> The problem happens both when using noflushd and
> with noflushd
> disabled.  The lockups have all occured during low
> disk activity, but
> 95% of the time disk activity is low, so this may
> just be a
> coincidence.
> 
> I would be happy to privide any further information
> that would be
> useful in debugging this problem, but I am not sure
> how to provide
> useful diagnostics for such a total and sudden
> lockup.
> 
i don't know if this is the same...but i have the same
dell inspiron 5000 for work and i was having this same
problem...the guys from dell did all of the
troubleshooting that i could bare...from having me
remove my hardrive and cd which provided temporary
fixes...in the end dell replaced my motherboard and i
have not had any more problems.




> As long as I am posting IDE problems... On a
> different computer, every
> time the machine boots I get the errors
> hdc: dma_intr: status=0x51 { DriveReady SeekComplete
> Error }
> hdc: dma_intr: error=0x84 { DriveStatusError BadCRC
> }
> repeated 4 times.  hdc is an IBM-DTLA-307045
> attached to an Intel
> PIIX4 controller (440BX).  IBM's drive fitness test
> does not report
> any errors, and I have no other errors or
> difficulties in using the
> drive.  Should I be concerned?
> 
> --
> Thanks,
> Jeff Lessem.
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - Send FREE e-cards for every occasion!
http://greetings.yahoo.com
