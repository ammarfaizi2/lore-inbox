Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132350AbRAGOA3>; Sun, 7 Jan 2001 09:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132692AbRAGOAN>; Sun, 7 Jan 2001 09:00:13 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53518 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132685AbRAGN74>; Sun, 7 Jan 2001 08:59:56 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: cw@f00f.org (Chris Wedgwood)
Date: Sun, 7 Jan 2001 14:01:05 +0000 (GMT)
Cc: ebiederm@xmission.com (Eric W. Biederman),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        viro@math.psu.edu (Alexander Viro),
        stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
In-Reply-To: <20010107210818.A2230@metastasis.f00f.org> from "Chris Wedgwood" at Jan 07, 2001 09:08:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FGNf-0002hM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> THis means we limit all NFS file sizes to 32-bits unless we have
> NFSv3? (I assume v3 is where the 64-bit file sizes comes from? or
> does it predate that?)

NFSv2 has a 32bit file offset. Thus the largest file on NFSv2 you want to 
touch is 2Gig.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
