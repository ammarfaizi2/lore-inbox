Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130199AbRBTMhU>; Tue, 20 Feb 2001 07:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129907AbRBTMhK>; Tue, 20 Feb 2001 07:37:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28168 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130199AbRBTMg7>; Tue, 20 Feb 2001 07:36:59 -0500
Subject: Re: Probs with PCI bus master DMA to user space
To: norbert.roos@cluster-labs.de (Norbert Roos)
Date: Tue, 20 Feb 2001 12:37:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A924D8A.FBEAD695@cluster-labs.de> from "Norbert Roos" at Feb 20, 2001 11:57:14 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VC2m-0006Xe-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm currently writing a driver which wants to transfer data between main
> memory and a PCI device. The data buffers are allocated by the program
> which uses the driver and therefore lie in the user space. Pointers to

Allocate the buffers in the kernel and mmap() them into user space
