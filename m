Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317414AbSGITeW>; Tue, 9 Jul 2002 15:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSGITeV>; Tue, 9 Jul 2002 15:34:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15877 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317414AbSGITeV>; Tue, 9 Jul 2002 15:34:21 -0400
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
To: root@chaos.analogic.com
Date: Tue, 9 Jul 2002 20:59:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
       trond.myklebust@fys.uio.no (Trond Myklebust), nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020709150615.14559A-100000@chaos.analogic.com> from "Richard B. Johnson" at Jul 09, 2002 03:13:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17S18w-0005a7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That is what it's supposed to do with files. The attached code clearly
> shows that it doesn't work with directories. The fsync() instantly
> returns, even though there is buffered data still to be written.

Your understanding or code is wrong. Its hard to tell which.

fsync on the directory syncs the directory metadata not the file metadata
