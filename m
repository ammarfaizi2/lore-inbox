Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132311AbRAGN4j>; Sun, 7 Jan 2001 08:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132495AbRAGN4a>; Sun, 7 Jan 2001 08:56:30 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49934 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132311AbRAGN4K>; Sun, 7 Jan 2001 08:56:10 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 7 Jan 2001 13:57:17 +0000 (GMT)
Cc: cw@f00f.org (Chris Wedgwood), alan@lxorguk.ukuu.org.uk (Alan Cox),
        viro@math.psu.edu (Alexander Viro),
        stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
In-Reply-To: <m1r92fj10c.fsf@frodo.biederman.org> from "Eric W. Biederman" at Jan 07, 2001 12:05:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FGK1-0002gX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Putting the LFS checks, & max filesize checks into the VFS sounds
> right for 2.4.x because it fixes lots of filesystems, with just a
> couple of lines of code. 

Rather more than that, and it only fixes those using generic_file_*

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
