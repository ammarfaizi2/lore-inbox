Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132251AbRAATCk>; Mon, 1 Jan 2001 14:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132310AbRAATCa>; Mon, 1 Jan 2001 14:02:30 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23823 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132251AbRAATCK>; Mon, 1 Jan 2001 14:02:10 -0500
Subject: Re: NFS-Root on AIX
To: pstadt@stud.fh-heilbronn.de (Oliver Paukstadt)
Date: Mon, 1 Jan 2001 18:33:25 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <Pine.LNX.4.05.10101011917520.23540-100000@lara.stud.fh-heilbronn.de> from "Oliver Paukstadt" at Jan 01, 2001 07:27:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14D9lv-00019l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > NFS doesnt handle this elegantly for NFSv2 - are you using v2 or v3 ?
> That's the question! What does the RedHat 7 support? ;-)

2.2.16-* will be NFSv2

This means the dev_t is passed uninterpreted between server and client. You may
find you need to NFS mount the directory on a Linux box, mknod the device
files over NFS and then let the diskless client use them

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
