Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLHPJk>; Fri, 8 Dec 2000 10:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQLHPJa>; Fri, 8 Dec 2000 10:09:30 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:52717 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S129387AbQLHPJR>; Fri, 8 Dec 2000 10:09:17 -0500
Date: Fri, 8 Dec 2000 14:38:38 +0000 (GMT)
From: Guennadi Liakhovetski <gvlyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: BIOS / kernel vrt IDE DMA
Message-ID: <Pine.GSO.4.21.0012081432340.9069-100000@acms23>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

I posted on this subject before, but this time I just would like to
receive an answer to the question - BIOS or kernel - who rules?

So, the question: is it either
1) there ARE situations when BIOS's inability to support DMA for IDE
cannot be fixed by the software or
2) it IS always possible, so, something is wrong with the software
(kernel / its configuration)

For those of you unfamiliar with the situation - some details:
I've been fighting with this problem for a few weeks now. The problem
seems to be that my BIOS does not support DMA for IDE and the kernel
cannot bypass it. The chipset is ok (Intel 430FX), the disk too, afaik I
included all possible parameters in the kernel (2.2.17 + ide patch). But
the BIOS is old (AMI 1.00.04.CA0 for Intel Morrison64 aka Advanced/MN mobo
with a P-75 and onboard S3-Trio64) and no upgrades exist. 

Also, I read somewhere, that one often can flash a 'non-native'
BIOS... Does anybody know of identical mobos (430FX + S3-Trio64)? Note,
that Morrison32's BIOS (S3-Trio32) does not suit.

Thanks
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
