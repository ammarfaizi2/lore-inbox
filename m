Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263438AbTJLJWX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 05:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbTJLJWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 05:22:23 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:28033 "HELO
	longlandclan.hopto.org") by vger.kernel.org with SMTP
	id S263438AbTJLJWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 05:22:21 -0400
Message-ID: <3F891CC9.8020507@longlandclan.hopto.org>
Date: Sun, 12 Oct 2003 19:20:09 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Denebeim <denebeim@deepthot.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with Maxtor 120 GB drive
References: <slrnbohfu7.1mb.denebeim@hotblack.deepthot.org>
In-Reply-To: <slrnbohfu7.1mb.denebeim@hotblack.deepthot.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jay Denebeim wrote:

> I just purchased a Maxtor 120GB MXTL01P120 hard drive and when I tried
> to install it with Redhat it wrote over the partition table describing
> it as only 8GB.  I tried doing linux rescue and lilo complained that
> the physical and logical disk sizes did not match (logical was the
> correct size, physical was the 8GB).

I'm no guru here, but as far as I know, 8GB will be about all you'll see 
without using logical block addressing (LBA).  Using the lba32 option in 
your lilo.conf might help.

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

iD8DBQE/iRzMIGJk7gLSDPcRAkqfAJ0UAV5nVhdTbLZ5FqSOsv8sUmT7MwCfT/OJ
HhGjZzU6WiXOAAfMAyvT26g=
=p0ya
-----END PGP SIGNATURE-----

