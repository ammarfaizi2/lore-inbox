Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131965AbRAaRQs>; Wed, 31 Jan 2001 12:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132044AbRAaRQi>; Wed, 31 Jan 2001 12:16:38 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:29910 "EHLO
	smtprelay1.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S131409AbRAaRQZ>; Wed, 31 Jan 2001 12:16:25 -0500
Message-ID: <3A7847B1.C8ABDDE1@adelphia.net>
Date: Wed, 31 Jan 2001 12:13:21 -0500
From: Stephen Wille Padnos <stephenwp@adelphia.net>
X-Mailer: Mozilla 4.76C-SGI [en] (X11; U; IRIX64 6.5 IP28)
X-Accept-Language: en
MIME-Version: 1.0
To: Byron Stanoszek <gandalf@winds.org>
CC: "David D.W. Downey" <pgpkeys@hislinuxbox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA VT82C686X
In-Reply-To: <Pine.LNX.4.21.0101311148560.20840-100000@winds.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Byron Stanoszek wrote:

> On Tue, 30 Jan 2001, David D.W. Downey wrote:
>
> > I removed the ide and ata setting. System is running stably as in no
> > kernel crashes, but I am getting daemon and shell crashes. With this
> > current kernel I've had 1 kernel crash in about 3 hours as compared to 1
> > every 10 or 15 minutes. Crash, reboot, 10 minutes or so crash, reboot. ect
> > ect.
> >
> > I'm wanting to test something else out. I'm wondering if there isn't some
> > hardware issue with the RAM. This particular board will do 1GB of PC133,
> > or 2.5GB of PC100. I'm wondering if there isn't something wrong with how
> > it reads the speed and the appropriate limitation. It's running stably if
> > I only run 768MB of PC133 RAM. But if I run a solid 1GB of PC133 I get
> > segfaults and sig11 crashes constantly. All the RAM has been
> > professionally tested and certified.
>
> That definitely sounds like a RAM problem. The system should perform the same
> independent of how many RAM chips you put in there (segfault-wise). If you're
> still in doubt, you can try booting up with memtest86 and run it for several
> hours with only the memory chip that you think might be causing the problem.
>

Even though the motherboard *should* perform the same regardless of the amount
of RAM, it may not.  Physically, the refresh needs higher current drive when
there are more modules.  I have seen a BIOS option to set the DRAM refresh
current (RAS, CAS settable to 10 or 16 mA each), but that was only on one
motherboard that I can remember - you might want to check for this.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
