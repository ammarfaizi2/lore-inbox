Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130755AbRAWSzB>; Tue, 23 Jan 2001 13:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130324AbRAWSyv>; Tue, 23 Jan 2001 13:54:51 -0500
Received: from site3.talontech.com ([208.179.68.88]:16209 "EHLO
	site3.talontech.com") by vger.kernel.org with ESMTP
	id <S130755AbRAWSyh>; Tue, 23 Jan 2001 13:54:37 -0500
Message-ID: <3A6D6290.6D21B532@talontech.com>
Date: Tue, 23 Jan 2001 02:53:04 -0800
From: Ben Ford <bford@talontech.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark I Manning IV <mark4@purplecoder.com>
CC: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Total loss with 2.4.0 (release)
In-Reply-To: <Pine.LNX.3.95.1010123101348.1264A-100000@chaos.analogic.com> <3A6D6A9C.98237DE4@purplecoder.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark I Manning IV wrote:

> > >
> > > > I think that your linux's partition has not been overwritten, but only the MBR
> > > > of your disk, so you probably just need to reinstall lilo. Insert your
> > > > installation bootdisk into your pc, then skip all the setup stuff, but the
> > > > choose of the partition where you want to install and the source from where
> > > > you want to install, then select just the lilo configuration (bootconfiguration
> > > > I mean), complete that step and reboot your machine, lilo will'be there again.
>
> Oopts I did this last week (fdisk /mbr doesnt do lilo any good :P)
>
> Insert Debian boot cd, boot to install, press Alt f2  Create mountpoint,
> Mount /dev/hda1, CD to that directory chroot to it, cd into /root and
> ./.profile (prolly not needed but can be useful sometimes)  run lilo.
> All fixed (except by the time i rebooted my motherboard had commited
> suicide on me for being so stupid.  Im about to go collect the
> replacement right now :)

Holy cow.  Try this.

1.  Boot from Slackware CD
2.  At boot prompt enter:   vmlinuz root=/dev/hda3 (replace with correct device of
course)
3.  Boot.
4.  Run lilo.
5.  Reboot if you want to.

-b


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
