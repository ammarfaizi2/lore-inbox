Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135981AbREBV3L>; Wed, 2 May 2001 17:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135989AbREBV3B>; Wed, 2 May 2001 17:29:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42770 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135981AbREBV2u>; Wed, 2 May 2001 17:28:50 -0400
Subject: Re: DPT I2O RAID and Linux I2O
To: patrick.allaire@isaacnewtontech.com (Patrick Allaire)
Date: Wed, 2 May 2001 22:32:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <HEEIIHGBKLFOBPOOOJHCOECCCHAA.patrick.allaire@isaacnewtontech.com> from "Patrick Allaire" at May 02, 2001 05:18:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14v4Et-0004Nr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The slave computer is isolated from the pci bus with a non-transparent
> pci-to-pci bridge : INTEL (DEC) 21554
> 
> Basicly I have to transmit data between the host and the local system by the
> pci bus.

Ok thats nothing to do with I2O itself. Some hardware has the messaging
layer built into it as the messenger is very simple and stuff like the 21554
are using in I2O controllers.

You might find i2o_pci.c and the i2o_core message passing code interesting
but probably not that much. The I2O 1.5 specification covers the hardware
interface briefly and that bit is worth reading. Ignore the rest.

