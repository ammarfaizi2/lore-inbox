Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270877AbTHFTcD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270967AbTHFTcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:32:02 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:17933 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270871AbTHFTbn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:31:43 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
Subject: Re: [2.6] system is very slow during disk access
Date: Wed, 6 Aug 2003 21:31:42 +0200
User-Agent: KMail/1.5.3
References: <200308062052.10752.fsdeveloper@yahoo.de> <200308062129.26371.frank.vandamme@student.kuleuven.ac.be>
In-Reply-To: <200308062129.26371.frank.vandamme@student.kuleuven.ac.be>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308062131.46017.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 06 August 2003 21:29, Frank Van Damme wrote:
> Maybe you just didn't enable DMA on them. Use hdparm -v /dev/foo to find
> out.

DMA is on.

root@lfs:/home/mb> hdparm -v /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 14244/16/63, sectors = 80418240, start = 0


root@lfs:/home/mb> hdparm -v /dev/hdc

/dev/hdc:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 14244/16/63, sectors = 80418240, start = 0


- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MVeeoxoigfggmSgRAkVfAJ4/SIBNLy7v4+E5OgA/z4FjMcKFfgCfTF94
orXbTJpyryLpKXwjzkZoyqU=
=4jnz
-----END PGP SIGNATURE-----

