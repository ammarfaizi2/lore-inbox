Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131245AbRAGQQ1>; Sun, 7 Jan 2001 11:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132425AbRAGQQR>; Sun, 7 Jan 2001 11:16:17 -0500
Received: from slc457.modem.xmission.com ([166.70.2.203]:62473 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S131245AbRAGQQG>; Sun, 7 Jan 2001 11:16:06 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: cw@f00f.org (Chris Wedgwood), viro@math.psu.edu (Alexander Viro),
        stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <E14FGK1-0002gX-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jan 2001 07:56:53 -0700
In-Reply-To: Alan Cox's message of "Sun, 7 Jan 2001 13:57:17 +0000 (GMT)"
Message-ID: <m1itnrif62.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Putting the LFS checks, & max filesize checks into the VFS sounds
> > right for 2.4.x because it fixes lots of filesystems, with just a
> > couple of lines of code. 
> 
> Rather more than that, and it only fixes those using generic_file_*

True.  But it is noticeable fewer lines of code than doing it all
once for each fs.

Eric


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
