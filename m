Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290565AbSA3Ubr>; Wed, 30 Jan 2002 15:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290572AbSA3Ub2>; Wed, 30 Jan 2002 15:31:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9477 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290570AbSA3UbS>; Wed, 30 Jan 2002 15:31:18 -0500
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
To: tao@acc.umu.se (David Weinehall)
Date: Wed, 30 Jan 2002 20:43:48 +0000 (GMT)
Cc: yoder1@us.ibm.com (Kent E Yoder), alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <20020130205839.S1735@khan.acc.umu.se> from "David Weinehall" at Jan 30, 2002 08:58:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16W1a8-0008MS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is this the best way to make sure the PCI cache is flushed for writes that 
> > need to happen immediately?  I don't see many other drivers doing it...
> 
> Wouldn't creating a flush_and_writew() or similar be an idea here?

You can't write a generic function for it. The PCI rules are all quite
simple and well documented, unfortunately it a book nobody has 8)
