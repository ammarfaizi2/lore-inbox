Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTLCVKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTLCVKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:10:47 -0500
Received: from adsl-68-78-201-244.dsl.klmzmi.ameritech.net ([68.78.201.244]:28424
	"EHLO mail.domedata.com") by vger.kernel.org with ESMTP
	id S261812AbTLCVKh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:10:37 -0500
From: tabris <tabris@tabris.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23-pac1 (and others) issue with PDC20265
Date: Wed, 3 Dec 2003 16:10:28 -0500
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200312031610.34288.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have an ASUS A7V266-E motherboard, AMD AthlonXP 1800+ CPU.
several hard drives of various makes.

I've tested a couple different kernels... all (afaik) with preempt.
I've tried 2.4.22-10mdk, plus 2.4.23-pac1+preempt+lowlatency, and also a 
2.4.22-ac4+preempt

What I'm getting are deadlocks on what I think are dma issues when copying 
btwn hdf and hdg.
according to /proc/ide/*/model
hda is a WDC AC28400R
hdb is a Maxtor 93652U8
hde is a WDC WD200BB-32BSA0
hdf is a Maxtor 4D060H3
hdg is a Maxtor 4D060H3 (just installed today, likely used)

i've only gotten ONE error message 
Dec  3 12:51:12 tabriel kernel: hdf: dma_timer_expiry: dma status == 0x61

and that was with 2.4.22-10mdk

the rest all deadlock without ANY error messages.

Help?

- --
tabris
currently copying from hdf -> hdg with DMA turned off on hdf. going at 
about 1MB/minute, with some spikes.
- -
"Life would be much simpler and things would get done much faster if it
weren't for other people"
		-- Blore
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/zlFI1U5ZaPMbKQcRAlRBAJ9vJp2ujbmf8KcytXH6E3e0mG+P7gCeL951
p4JfhV5Y+eRpaq289AHRZ0Y=
=Zefz
-----END PGP SIGNATURE-----

