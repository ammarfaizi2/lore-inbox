Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317110AbSGCSBh>; Wed, 3 Jul 2002 14:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSGCSBg>; Wed, 3 Jul 2002 14:01:36 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43652 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317110AbSGCSBf>; Wed, 3 Jul 2002 14:01:35 -0400
Date: Wed, 3 Jul 2002 20:03:48 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Eduard Bloch <edi@gmx.de>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
In-Reply-To: <20020703155113.GA26299@zombie.inka.de>
Message-ID: <Pine.SOL.4.30.0207031955430.4553-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Jul 2002, Eduard Bloch wrote:

> Why not another way round? Just make the ide-scsi driver be prefered,
> and hack ide-scsi a bit to simulate the cdrom and adv.floppy devices
> that are expected as /dev/hd* by some user's configuration?
>
> To be honest - why keep ide-[cd,floppy,tape] when they can be almost
> completely replaced with ide-scsi? I know about only few cdrom devices
> that are broken (== not ATAPI compliant) but can be used with
> workarounds in the current ide-cd driver. OTOH many users do already
> need ide-scsi to access cd recorders and similar hardware, so they would
> benefit much more from having ide-scsi as default than few users of
> broken "atapi" drives.

THE PLAN is to have generic ATAPI driver and generic packet command
driver (ATAPI and SCSI).

:-)

--
Bartlomiej


