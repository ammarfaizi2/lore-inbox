Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265671AbTF2Om0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 10:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265674AbTF2Om0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 10:42:26 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:47876 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265671AbTF2OmZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 10:42:25 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IDE-disk spindown fails
Date: Sun, 29 Jun 2003 16:56:23 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306291656.32704.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I have a problem spinning down my Western Digital 80GB harddisk.
root@server:~> cat /proc/ide/hdc/model  
WDC WD800BB-00CAA1

Neither hdparm -S nor noflushd is able to spin down this disk.

The machine is a very old Pentium 1 machine. It's BIOS doesn't
recognize this new (I've bought it a few days ago) harddisk.
So I've set this IDE-channel to "none" in the BIOS to avoid
very long searches on this channel from BIOS while booting.

Reading and writing on the disk works quite fine.

/dev/hda is the drive, the system is installed on.
It's a very old 2GB Quantum drive.
root@server:~> cat /proc/ide/hda/model 
QUANTUM FIREBALL_TM2110A

The BIOS recognizes it and I'm able to spindown it.


Does linux depend on the BIOS when spinning down?

root@server:~> cat /proc/version 
Linux version 2.4.21 (mb@lfs) (gcc-Version 3.3.1 20030519 (prerelease)) #2 Son Jun 15 13:08:42 CEST 2003

If you want me to run any tests on the machine, or if you
want some information, I've not given, just ask, please.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 16:45:47 up  5:54,  4 users,  load average: 1.05, 1.04, 1.08

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+/v4goxoigfggmSgRAmnuAJ9z+ih7RLTZm4xPvk2k0a8Ia4wz9QCfckcI
onkajeTZ37uxFsjmSBmgVIc=
=PgqV
-----END PGP SIGNATURE-----

