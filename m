Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282664AbRLBUHW>; Sun, 2 Dec 2001 15:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281277AbRLBUHF>; Sun, 2 Dec 2001 15:07:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14611 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282664AbRLBUGr>; Sun, 2 Dec 2001 15:06:47 -0500
Subject: Re: 2.4.17pre2: devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Sun, 2 Dec 2001 20:14:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@borntraeger.net (Christian =?iso-8859-1?q?Borntr=E4ger?=),
        acmay@acmay.homeip.net (andrew may),
        ajschrotenboer@lycosmail.com (Adam Schrotenboer),
        linux-kernel@vger.kernel.org
In-Reply-To: <200112022001.fB2K16Q12503@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at Dec 02, 2001 01:01:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Ad0j-0004Qg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wouldn't say it's not back compatible. If you want to use a new
> devfsd feature, then you need the new devfs. The key difference
> between the old and new devfs core (aside from fixing those races) is
> that the new devfs core will spit out an EEXIST warning message
> whereas before it didn't. But his system still worked. It didn't
> break.

Ok so the old devfsd works but spews a few errors. Right - then I agree
with you. 

Alan
