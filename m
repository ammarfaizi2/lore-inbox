Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312408AbSCYMuM>; Mon, 25 Mar 2002 07:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312390AbSCYMuB>; Mon, 25 Mar 2002 07:50:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58118 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312408AbSCYMtq>; Mon, 25 Mar 2002 07:49:46 -0500
Subject: Re: [Cooker] (RFC) Supermount 2
To: danny@mailmij.org
Date: Mon, 25 Mar 2002 13:05:57 +0000 (GMT)
Cc: cooker@linux-mandrake.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203251316560.26580-100000@luna.ellen.dexterslabs.com> from "danny@mailmij.org" at Mar 25, 2002 01:21:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pUAf-0000Ux-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 3) Built-in support for packet-writing. ( i.e. insert packet-writing formatted disk and it loads appropriate kernel modules. )
> > 
> > There may be other features added if there is an interest in them. I will need assistance with the packet-writing support. I am only planning to do this for the 2.5.x and later kernels, so if anyone else wishes to back-port it to an older kerenl series, by all means do so. I have wanted to make some kind of contribution to this project for some time and I feel that this is something that will be useful.
> > 
> What about doing it in userspace? I remember seeing Alan Cox writing he 
> had a proof of concept of something like this on some ftp server (sorry, 
> cannot remember where).

http://ftp.linux.org.uk/pub/linux/alan - you want volumagic. Its a demo of
the theory (but quite usable).

Doing supermount in kernel is suprisingly hard, the locking and races you get
into are not nice at all - ask Juan about that
