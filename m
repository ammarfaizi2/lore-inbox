Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286333AbRLJSD6>; Mon, 10 Dec 2001 13:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286340AbRLJSDi>; Mon, 10 Dec 2001 13:03:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51978 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286337AbRLJSDV>; Mon, 10 Dec 2001 13:03:21 -0500
Subject: Re: mm question
To: volodya@mindspring.com
Date: Mon, 10 Dec 2001 18:12:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0112101242410.18043-100000@node2.localnet.net> from "volodya@mindspring.com" at Dec 10, 2001 12:43:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DUuv-0002tD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That sounds like agpgart needs fixing. Its going to be easier than hacking
> > the vm code
> 
> Well, I was trying to avoid that and simply distribute additional memory
> management routines with the driver. 

Thats going to be a no go. To create a new memory zone as  you need means
mucking around in the very depths of the mm code in the kernel core.
