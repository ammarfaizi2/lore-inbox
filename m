Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbTIMCId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 22:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTIMCId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 22:08:33 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:60800 "HELO
	longlandclan.hopto.org") by vger.kernel.org with SMTP
	id S261997AbTIMCIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 22:08:31 -0400
Message-ID: <3F627C13.6020608@longlandclan.hopto.org>
Date: Sat, 13 Sep 2003 12:08:19 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: getting a working CD-drive in 2.6
References: <20030912093837.GC2921@iain-vaio-fx405>
In-Reply-To: <20030912093837.GC2921@iain-vaio-fx405>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

iain d broadfoot wrote:

| 	Since starting using 2.6, I've been unable to use my cd-rw/dvd
| 	drive at all.

Okay, we need a little more information.

	What precise version of Linux 2.6?  2.6.0-test5?
	What model/make of CDRW/DVD drive?
	What interface?		e.g.	SCSI, IDE, USB, Firewire....
	What does 'dmesg' dump out?
	And yes, the .config might be useful.

| 	ide-scsi is disabled.

If it's an IDE drive, you'll want this _enabled_ before you'll be able
to write CDs.  Most of the burner software that I know of look for a
SCSI CD burner, not IDE.  ide-scsi is intended for making an IDE CD
burner appear as a SCSI device.

Don't reply directly to me -- I know quite a fair bit about Linux, but
compared to the majority of this list, I'm a newbie -- your reply is
best looked at by one of the gurus here.
- --
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Griffith Student No:           Course: Bachelor/IT (Nathan) |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/YnwTIGJk7gLSDPcRAqrgAJ99PeW5JatHh2X4jk+i9NxhF7pfUgCfaWH/
/KmNZLwl56F8w0NxC5kb82k=
=kTfu
-----END PGP SIGNATURE-----

