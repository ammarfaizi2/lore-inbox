Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132230AbRAAS6j>; Mon, 1 Jan 2001 13:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132251AbRAAS6U>; Mon, 1 Jan 2001 13:58:20 -0500
Received: from dns1.rz.fh-heilbronn.de ([141.7.1.18]:52687 "EHLO
	dns1.rz.fh-heilbronn.de") by vger.kernel.org with ESMTP
	id <S132230AbRAAS6O>; Mon, 1 Jan 2001 13:58:14 -0500
Date: Mon, 1 Jan 2001 19:27:45 +0100 (CET)
From: Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS-Root on AIX
In-Reply-To: <E14D9QE-00018E-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.05.10101011917520.23540-100000@lara.stud.fh-heilbronn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2001, Alan Cox wrote:

> > Last we had to use an AIX-Server as NFS-Server for NFSRoot-Boot.
> > 
> > It did not work, because the all Major-Device-Numbers in /dev/ are all
> > set to 0. The minor numbers are transported correctly. 
> 
> NFS doesnt handle this elegantly for NFSv2 - are you using v2 or v3 ?
That's the question! What does the RedHat 7 support? ;-)

Where is the switching for v2 or v3 as nfs-client done?
Kernel-Config CONFIG_NFS_V3 or mount-option nfsvers?

Which version does the nfsroot-boot use?

BYtE Oli

+++LINUX++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++Manchmal stehe ich sogar nachts auf und installiere mir eins....+++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
