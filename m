Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135608AbREBPvg>; Wed, 2 May 2001 11:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135599AbREBPv0>; Wed, 2 May 2001 11:51:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32016 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135598AbREBPvI>; Wed, 2 May 2001 11:51:08 -0400
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Date: Wed, 2 May 2001 16:54:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        jlundell@pobox.com (Jonathan Lundell), linux-kernel@vger.kernel.org
In-Reply-To: <20010502170303.M706@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at May 02, 2001 05:03:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uyxA-0003p0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Does POSIX state, that "/" is the directory/entry[1] separator?
> 2. Can a device node be an directory?
> 
> If 1. and not 2., there is no way to implement it like that.

Why not. It doesn't say what happens if there is pathname left over when you
hit the device specifically.

tar would archive the device node, not the options.


