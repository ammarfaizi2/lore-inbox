Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSGIRR1>; Tue, 9 Jul 2002 13:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSGIRR1>; Tue, 9 Jul 2002 13:17:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1669 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317005AbSGIRR0>; Tue, 9 Jul 2002 13:17:26 -0400
Date: Tue, 9 Jul 2002 13:22:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
In-Reply-To: <E17RyHb-0005Fa-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1020709130055.377A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002, Alan Cox wrote:

> > > not adhere to this convention.
> > 
> > Well, no. It's not supported. You can't get a valid file-descriptor...
> 
> Wrong (as usual)

Really? Then what is the meaning of fsync() on a read-only file-
descriptor? You can't update the information you can't change.

This is (as usual) just an example of your helpful responses.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

