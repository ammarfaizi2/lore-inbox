Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132125AbRAASkE>; Mon, 1 Jan 2001 13:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132210AbRAASjy>; Mon, 1 Jan 2001 13:39:54 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18191 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132125AbRAASjr>; Mon, 1 Jan 2001 13:39:47 -0500
Subject: Re: NFS-Root on AIX
To: pstadt@stud.fh-heilbronn.de (Oliver Paukstadt)
Date: Mon, 1 Jan 2001 18:11:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <Pine.LNX.4.05.10101011850430.19324-100000@lara.stud.fh-heilbronn.de> from "Oliver Paukstadt" at Jan 01, 2001 07:00:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14D9QE-00018E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Last we had to use an AIX-Server as NFS-Server for NFSRoot-Boot.
> 
> It did not work, because the all Major-Device-Numbers in /dev/ are all
> set to 0. The minor numbers are transported correctly. 

NFS doesnt handle this elegantly for NFSv2 - are you using v2 or v3 ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
