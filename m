Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265721AbTF2SZt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 14:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbTF2SZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 14:25:49 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:40970 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265721AbTF2SZs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 14:25:48 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Michael Buesch <fsdeveloper@yahoo.de>
Subject: Re: IDE-disk spindown fails
Date: Sun, 29 Jun 2003 20:39:56 +0200
User-Agent: KMail/1.5.2
References: <200306291656.32704.fsdeveloper@yahoo.de>
In-Reply-To: <200306291656.32704.fsdeveloper@yahoo.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306292039.56161.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sorry, I found out, that it's not a kernel problem.
It's a problem with the userspace noflushd daemon.

On Sunday 29 June 2003 16:56, Michael Buesch wrote:
> Hi.
>
> I have a problem spinning down my Western Digital 80GB harddisk.
> root@server:~> cat /proc/ide/hdc/model
> WDC WD800BB-00CAA1
>
> Neither hdparm -S nor noflushd is able to spin down this disk.
>
> The machine is a very old Pentium 1 machine. It's BIOS doesn't
> recognize this new (I've bought it a few days ago) harddisk.
> So I've set this IDE-channel to "none" in the BIOS to avoid
> very long searches on this channel from BIOS while booting.
>
> Reading and writing on the disk works quite fine.
>
> /dev/hda is the drive, the system is installed on.
> It's a very old 2GB Quantum drive.
> root@server:~> cat /proc/ide/hda/model
> QUANTUM FIREBALL_TM2110A
>
> The BIOS recognizes it and I'm able to spindown it.
>
>
> Does linux depend on the BIOS when spinning down?
>
> root@server:~> cat /proc/version
> Linux version 2.4.21 (mb@lfs) (gcc-Version 3.3.1 20030519 (prerelease)) #2
> Son Jun 15 13:08:42 CEST 2003
>
> If you want me to run any tests on the machine, or if you
> want some information, I've not given, just ask, please.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 20:38:10 up  9:47,  2 users,  load average: 0.00, 0.00, 0.00

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+/zJ8oxoigfggmSgRAo5YAJ4pZSWP+P6TIaBPeMZD5/8WywUiMQCfSDhu
156C96aWSa6ayS3E65WKtzA=
=FA5h
-----END PGP SIGNATURE-----

