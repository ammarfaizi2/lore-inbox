Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280697AbRKGMlV>; Wed, 7 Nov 2001 07:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280738AbRKGMlL>; Wed, 7 Nov 2001 07:41:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43538 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280697AbRKGMlB>; Wed, 7 Nov 2001 07:41:01 -0500
Subject: Re: Kernel crash when running program in gdb
To: d95-bli@nada.kth.se (=?ISO-8859-1?Q?Bj=F6rn_Lindberg?=)
Date: Wed, 7 Nov 2001 12:47:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111071320460.196-100000@nex.hemma.se> from "=?ISO-8859-1?Q?Bj=F6rn_Lindberg?=" at Nov 07, 2001 01:32:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161S78-00041g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ----<begin>----
> dma_intr: status=3D0x51 {DriveReady SeekComplete Error}
> dma_intr: error=3D0x40 {UncorrectableError}, LBAsect=3D45039979, sector=
> =3D218486
> end_request: I/O error, dev 21:0a (hde), sector 218486
> -----<end>-----

Uncorrectable error is a message from the disk itself indicating a bad block
on the drive
