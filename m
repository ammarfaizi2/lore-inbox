Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbUCKAIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbUCKAIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:08:53 -0500
Received: from ns2.len.rkcom.net ([80.148.32.9]:52374 "EHLO ns2.len.rkcom.net")
	by vger.kernel.org with ESMTP id S262903AbUCKAIN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:08:13 -0500
From: Florian Schanda <ma1flfs@bath.ac.uk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.3/scsi: Unexpected busfree while idle
Date: Thu, 11 Mar 2004 00:10:16 +0000
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403110010.21485.ma1flfs@bath.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

what does the following message mean (during scsi init at boot)?

scsi0: Unexpected busfree while idle
SEQADDR == 0x1

It appears each second or so, and the system can't move on. It only happens if 
a specific drive is on the scsi bus.

Does it mean that drive is broken?

The scsi bios (during system bootup, before linux) detects all discs properly 
(including this one), and in the scsi bios i can "veryfiy media" and it 
doesn't complain.


Thanks in advance,

	Florian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAT65rfCf8muQVS4cRAhi5AJ4oOQIrN2FkJs+3hWbNHvCFjnW2dACgkiqs
nnJ7vQa0yDwvnnIWZJQiylw=
=BJte
-----END PGP SIGNATURE-----
