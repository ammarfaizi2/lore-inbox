Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136524AbREDVln>; Fri, 4 May 2001 17:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136525AbREDVlg>; Fri, 4 May 2001 17:41:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57871 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136524AbREDVlY>; Fri, 4 May 2001 17:41:24 -0400
Subject: Re: DPT I2O RAID and Linux I2O
To: patrick.allaire@isaacnewtontech.com (Patrick Allaire)
Date: Fri, 4 May 2001 22:45:14 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <HEEIIHGBKLFOBPOOOJHCKEFECHAA.patrick.allaire@isaacnewtontech.com> from "Patrick Allaire" at May 04, 2001 03:19:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vnO0-00084r-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I look at the source from the i2o driver, i find that my module will
> have to primary create an handler to respond to the messages, but does the
> configuration of the i2o should be done by my module or it is gonna be done
> by the functions I cant use right now ? (i2o_pci_enable...)

You are looking much too high a level. The only stuff the hardware layer itself
does is the message fifo stack.

