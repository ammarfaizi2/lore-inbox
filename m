Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSGIQas>; Tue, 9 Jul 2002 12:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSGIQar>; Tue, 9 Jul 2002 12:30:47 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64018 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314680AbSGIQaq>; Tue, 9 Jul 2002 12:30:46 -0400
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
To: root@chaos.analogic.com
Date: Tue, 9 Jul 2002 17:56:11 +0100 (BST)
Cc: trond.myklebust@fys.uio.no (Trond Myklebust), nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020709104427.27442B-100000@chaos.analogic.com> from "Richard B. Johnson" at Jul 09, 2002 11:06:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17RyHb-0005Fa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > not adhere to this convention.
> 
> Well, no. It's not supported. You can't get a valid file-descriptor...

Wrong (as usual)

> If an application insists, it is up to the application to determine,
> probably once upon startup, just what kind of file synchronization
> is supported.

Linux defines fsync for directories
