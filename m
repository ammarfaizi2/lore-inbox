Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132105AbRAASbX>; Mon, 1 Jan 2001 13:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132125AbRAASbN>; Mon, 1 Jan 2001 13:31:13 -0500
Received: from dns1.rz.fh-heilbronn.de ([141.7.1.18]:40143 "EHLO
	dns1.rz.fh-heilbronn.de") by vger.kernel.org with ESMTP
	id <S132105AbRAASbE>; Mon, 1 Jan 2001 13:31:04 -0500
Date: Mon, 1 Jan 2001 19:00:34 +0100 (CET)
From: Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: NFS-Root on AIX
Message-ID: <Pine.LNX.4.05.10101011850430.19324-100000@lara.stud.fh-heilbronn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HY HY

Last we had to use an AIX-Server as NFS-Server for NFSRoot-Boot.

It did not work, because the all Major-Device-Numbers in /dev/ are all
set to 0. The minor numbers are transported correctly. 

A mount between two AIXes showed no Problems.

I tried this with various OS-Levels of AIX 4.3.x.x. and 4.2.x.x
Linux-Kernel was 2.2.16 on i686 and S/390 with various patches.

BYtE Oli

+++LINUX++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++Manchmal stehe ich sogar nachts auf und installiere mir eins....+++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
