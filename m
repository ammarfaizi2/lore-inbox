Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289270AbSA3PWG>; Wed, 30 Jan 2002 10:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289278AbSA3PV4>; Wed, 30 Jan 2002 10:21:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1298 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289270AbSA3PVu>; Wed, 30 Jan 2002 10:21:50 -0500
Subject: Re: [PATCH] clipped disk reports clipped lba size
To: etrapani@unesco.org.uy (Eduardo =?iso-8859-1?Q?Tr=E1pani?=)
Date: Wed, 30 Jan 2002 15:34:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C580AF6.90EF7086@unesco.org.uy> from "Eduardo =?iso-8859-1?Q?Tr=E1pani?=" at Jan 30, 2002 12:02:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VwkT-0007Zj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is a patch to solve that.  I am sure there is a more elegant solution, I guess we could add a "lba_size=" or something like that as a boot parameter.
> The patch against 2.4.17 does this:  if the geometry has been forced then use it to calculate the lba size and ignore the (possibly clipped) answer from the disk.

If you get the 2.4.18pre-ac patches that have the new IDE code in them this
should already be covered, along with such nice details as 160Gb disks.

Alan
