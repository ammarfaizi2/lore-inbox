Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbRBSBan>; Sun, 18 Feb 2001 20:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbRBSBad>; Sun, 18 Feb 2001 20:30:33 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53262 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129281AbRBSBaX>; Sun, 18 Feb 2001 20:30:23 -0500
Subject: Re: [patch] smbfs does not support LFS (2.4.1-ac18)
To: urban@teststation.com (Urban Widmark)
Date: Mon, 19 Feb 2001 01:30:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.30.0102180118460.10156-100000@cola.teststation.com> from "Urban Widmark" at Feb 18, 2001 03:13:30 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Uf9q-00024z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it ok to at mount time set it to non-LFS and then later change it to be
> something larger? smbfs doesn't actually know what the server and smbmount
> negotiates until later, but no smbfs operation can take place before that
> anyway.

You can change it per superblock later at the moment. Its probably best
to set it as soon as possible. NFS sets it at mount time conditional on
NFSv2 versus v3 for example

Alan

