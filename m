Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136714AbREAUmd>; Tue, 1 May 2001 16:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136715AbREAUmX>; Tue, 1 May 2001 16:42:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50443 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136714AbREAUmR>; Tue, 1 May 2001 16:42:17 -0400
Subject: Re: DPT I2O RAID and Linux I2O
To: patrick.allaire@isaacnewtontech.com (Patrick Allaire)
Date: Tue, 1 May 2001 21:46:09 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <HEEIIHGBKLFOBPOOOJHCOEPKCGAA.patrick.allaire@isaacnewtontech.com> from "Patrick Allaire" at May 01, 2001 02:34:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uh2D-0002LG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this I2O implementation supporting PCI devices ?

Yes

> Yesterday I post something about that, I have a CompactPCI computer with 2
> computers in it. One master and one slave. The slave one, is has a non
> transparent pci-to-pci bridge : DEC (INTEL) 21554, wich support I2O
> messaging, I want both computer to communicate by this mean, but I cant seam

I2O messaging and I2O protocol are two things. Most sane vendors use I2O
messaging hardware to implement something that looks a little more like a device
control protocol than SNA.

Alan



