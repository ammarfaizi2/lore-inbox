Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284311AbRLBTtl>; Sun, 2 Dec 2001 14:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284303AbRLBTtb>; Sun, 2 Dec 2001 14:49:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7187 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284306AbRLBTtT>; Sun, 2 Dec 2001 14:49:19 -0500
Subject: Re: 2.4.17pre2: devfs: devfs_mk_dir(printers): could not append to dir: dffe45c0 "", err: -17
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Sun, 2 Dec 2001 19:57:22 +0000 (GMT)
Cc: linux-kernel@borntraeger.net (Christian =?iso-8859-1?q?Borntr=E4ger?=),
        acmay@acmay.homeip.net (andrew may),
        ajschrotenboer@lycosmail.com (Adam Schrotenboer),
        linux-kernel@vger.kernel.org
In-Reply-To: <200112021941.fB2Jfmg12171@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at Dec 02, 2001 12:41:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Acjq-0004M3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I consider this issue closed. I'd suggest you contact Mandrake and get
> them to upgrade to devfsd-v1.3.20, remove the boot script code and use
> the RESTORE directive instead. This requires v1.2 of the devfs core
> (found in 2.4.17-pre1).

So the devfs in 2.4.17pre isnt back compatible - definitely 2.5 material
then. This is the same sort of reason the 32bit uid quota code can't go into
2.4 proper. Its a pain but its not reasonable to expect every random devfs
user to handle this in a stable tree update

