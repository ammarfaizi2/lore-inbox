Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285167AbRLFQuv>; Thu, 6 Dec 2001 11:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285164AbRLFQul>; Thu, 6 Dec 2001 11:50:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12814 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285051AbRLFQu1>; Thu, 6 Dec 2001 11:50:27 -0500
Subject: Re: question about kernel 2.4 ramdisk
To: david@gibson.dropbear.id.au (David Gibson)
Date: Thu, 6 Dec 2001 16:55:02 +0000 (GMT)
Cc: cr@sap.com (Christoph Rohland),
        tachino@open.nm.fujitsu.co.jp (Tachino Nobuhiro),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        padraig@antefacto.com (Padraig Brady),
        scho1208@yahoo.com (Roy S.C. Ho), linux-kernel@vger.kernel.org
In-Reply-To: <20011206173755.D16513@zax> from "David Gibson" at Dec 06, 2001 05:37:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C1na-0002Cg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> simplicity and ramfs with limits is quite a bit less complex than
> shmfs.  Of course, ramfs without limits is even simpler which is, I
> believe, why Linus didn't merge the patch in the first place.

Ramfs without limits is useless. It doesn't provide any guidance to an fs
implementor about error handling. Its _too_ simple.

Alan
