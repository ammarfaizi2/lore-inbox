Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143911AbRAHOjr>; Mon, 8 Jan 2001 09:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144066AbRAHOjh>; Mon, 8 Jan 2001 09:39:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1029 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143911AbRAHOjf>; Mon, 8 Jan 2001 09:39:35 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 8 Jan 2001 14:40:45 +0000 (GMT)
Cc: stefan@hello-penguin.com (Stefan Traby),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0101080821450.4061-100000@weyl.math.psu.edu> from "Alexander Viro" at Jan 08, 2001 08:35:10 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FdTa-0004fs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Why not start to fix this problem outside the funny switch/case in glibc ?
> > The filesystem itself should able to handle this.
> 
> Sigh... And the API would be?

In SuS its pathconf()

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
