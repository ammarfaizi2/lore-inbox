Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131910AbQLZXnN>; Tue, 26 Dec 2000 18:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132157AbQLZXnD>; Tue, 26 Dec 2000 18:43:03 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:8601 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S131910AbQLZXms>; Tue, 26 Dec 2000 18:42:48 -0500
Date: Tue, 26 Dec 2000 23:11:43 +0000 (GMT)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: linux-kernel@vger.kernel.org
cc: Andre Hedrick <andre@linux-ide.org>
Subject: Another faulty motherboard
Message-ID: <Pine.GSO.4.21.0012262242100.20505-100000@acms23>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ide-dma.c one reads:

 * Some people have reported trouble with Intel Zappa motherboards.
 * This can be fixed by upgrading the AMI BIOS to version 1.00.04.BS0,
 * available from ftp://ftp.intel.com/pub/bios/10004bs0.exe
 * (thanks to Glen Morrell <glen@spin.Stanford.edu> for researching this).

Which suggests, that a faulty BIOS can cause problems with IDE
Bus-Mastering, that are impossible to fix (at present at least) otherwise
but by upgrading the BIOS. Then, I think, you can add one more problematic
board to the list - Intel Aladdin (in other sources Morrison64) aka
Advanced/AL and no BIOS upgrade, fixing the problem available (at least I
was not able to find one, the latest tested being 1.00.04.CA0). In
particular the problem is - impossible to turn IDE DMA on. At least this
is my current understanding.

At least I was unable to turn IDE DMA on with the help of many of the
net-folk. However, some tests suggested (although not 100%) that Win* was
able to do this...

Cheers
Guennadi
___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
