Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132463AbRAGOTY>; Sun, 7 Jan 2001 09:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132861AbRAGOTO>; Sun, 7 Jan 2001 09:19:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63502 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132865AbRAGOS7>; Sun, 7 Jan 2001 09:18:59 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: cw@f00f.org (Chris Wedgwood)
Date: Sun, 7 Jan 2001 14:20:06 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        ebiederm@xmission.com (Eric W. Biederman),
        viro@math.psu.edu (Alexander Viro),
        stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
In-Reply-To: <20010108030735.B2844@metastasis.f00f.org> from "Chris Wedgwood" at Jan 08, 2001 03:07:35 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FGg4-0002jV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> .. or we can check 'up one level' by adding another method to struct
> file_operations perhaps (gross?).

Not feasible. SOme work has to be done by the fs in certain cases. I can cover
the majority of them tho
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
