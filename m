Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275279AbTHGLFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 07:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275281AbTHGLFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 07:05:16 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:30854 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S275279AbTHGLFJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 07:05:09 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.6] system is very slow during disk access
Date: Thu, 7 Aug 2003 12:12:23 +0200
User-Agent: KMail/1.5.3
References: <Pine.SOL.4.30.0308070129050.19328-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0308070129050.19328-100000@mion.elka.pw.edu.pl>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308071212.40254.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 07 August 2003 01:30, Bartlomiej Zolnierkiewicz wrote:
> After removing CONFIG_IDEDMA_IVB=y from your config
> "Speed warnings" should go away.


Aug  7 12:08:35 lfs kernel: blk: queue c04a795c, I/O limit 4095Mb (mask 0xffffffff)
Aug  7 12:08:35 lfs kernel: hdb: Speed warnings UDMA 3/4/5 is not functional.
Aug  7 12:08:35 lfs kernel: blk: queue c04a82ac, I/O limit 4095Mb (mask 0xffffffff)
Aug  7 12:08:35 lfs kernel: ide1: Speed warnings UDMA 3/4/5 is not functional.
Aug  7 12:08:35 lfs kernel: hdd: Speed warnings UDMA 3/4/5 is not functional.

Speed-warning from hda disappeared, but ide1 is still there.
(hdb and hdd are no disks. They are CD-drives, so that's no problem, yet)

>
> --
> Bartlomiej

- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MiYVoxoigfggmSgRAqyQAJ4oAIJ15geaovtcxpAOd/YGa0xPCQCdGOV8
KP6PqIdC9gJoB0mIu0zBP08=
=8ssm
-----END PGP SIGNATURE-----

