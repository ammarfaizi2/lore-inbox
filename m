Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264615AbTFANeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264618AbTFANeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:34:10 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:27093 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S264615AbTFANeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:34:08 -0400
To: linux-kernel@vger.kernel.org
Subject: USB 2.0 with 250Gb disk and insane loads
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 01 Jun 2003 15:47:30 +0200
Message-ID: <87fzmthpu5.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm trying to nail own a problem here, with my shiny new Maxtor 250Gb
USB 2.0 disk. Under 2.4 (vanilla, latest 21-preX and 21-preX-acY) the
disk will mount and talk nicely. As soon as any load hits it, e.g. a
single cp from my internal CD-ROM to the disk, the mahcine load will
sky-rocket and at some point within a few minuter hang the machine.

On 2.5 (vanilla and -mm) the load will show as i/o-wait and at some
point hang any access to the drive, but the kernel will go on working.

The drive will be dicovered nicely by the hotplug scripts and it will
load the apropriate drivers to make it show up as /dev/sda.

Any ideas how to nail down this problem when 2.4 will say nothing
before it locks hard and 2.5 doesnt say aything but goes off to hang
itself after a while with no furter clue?

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+2gPvCQ1pa+gRoggRAqkZAKCLSHDpOx8f/zL0PFwBsdSdoWjYgACeO3KW
RjW6OBQwUCgJ0V/sprQNSKk=
=HYxq
-----END PGP SIGNATURE-----
