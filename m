Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282936AbRLDJCH>; Tue, 4 Dec 2001 04:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282939AbRLDJB6>; Tue, 4 Dec 2001 04:01:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27664 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282936AbRLDJBo>; Tue, 4 Dec 2001 04:01:44 -0500
Subject: Re: Linux/Pro  -- clusters
To: becker@scyld.com (Donald Becker)
Date: Tue, 4 Dec 2001 09:10:35 +0000 (GMT)
Cc: davidel@xmailserver.org (Davide Libenzi),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.10.10112032057070.978-100000@vaio.greennet> from "Donald Becker" at Dec 03, 2001 09:09:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BBb1-0001KS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    a SCSI device layer that isn't three half-finished clean-ups

Beginning (at last)

>    a VFS layer that doesn't require the kernel to know a priori all of
>      the filesystem types that might be loaded

That was done a while ago. File systems are one by one being moved from
using the union of stuff to the fs specific pointer. New file systems don't
have to go hack the inode etc

Alan
