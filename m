Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135991AbREBVQB>; Wed, 2 May 2001 17:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135981AbREBVPs>; Wed, 2 May 2001 17:15:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37394 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135977AbREBVP3>; Wed, 2 May 2001 17:15:29 -0400
Subject: Re: DPT I2O RAID and Linux I2O
To: patrick.allaire@isaacnewtontech.com (Patrick Allaire)
Date: Wed, 2 May 2001 22:19:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <HEEIIHGBKLFOBPOOOJHCIECBCHAA.patrick.allaire@isaacnewtontech.com> from "Patrick Allaire" at May 02, 2001 05:11:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14v41x-0004Mt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I understand correctly, some vendor would put I2O messaging hardware but
> they would use it in a non-standard way ? So, if they dont support the I2O
> protocol with their hardware, I will have to do it in another  way...
> 
> Is there a simple way to find out if my device support I2O protocol ? Maybe
> its written in the BAR or in the CSR, but does linux find those devices
> automaticly ? or do I have to do it in my module ? If I must do it myself,
> do you know any device that is doing something like I do ? so I could look
> at the code.

If its running as an I2O device, it will be class I2O PCI and it'll have about
300K+ of firmware (probably vxworks) loaded onto it and a chunk of RAM. WHat
sort of device is this ?


