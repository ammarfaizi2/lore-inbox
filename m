Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135892AbRD0LGy>; Fri, 27 Apr 2001 07:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135828AbRD0LGo>; Fri, 27 Apr 2001 07:06:44 -0400
Received: from [212.208.59.162] ([212.208.59.162]:35834 "EHLO zeus.nsi.fr")
	by vger.kernel.org with ESMTP id <S135939AbRD0LG3>;
	Fri, 27 Apr 2001 07:06:29 -0400
Message-ID: <3AE949F6.B92F6CB1@nsi.fr>
Date: Fri, 27 Apr 2001 12:29:10 +0200
From: Eric Pennamen <Pennamen@nsi.fr>
X-Mailer: Mozilla 4.75 [fr] (Win98; U)
X-Accept-Language: fr
MIME-Version: 1.0
To: dave.fraser@baesystems.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Resetting a PCI device
In-Reply-To: <001901c0ceff$c0ae88e0$64ccdd89@edinbr.gmav.gecm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why don't do a local RESET by writing in CNTRL register of the PLX9080 ?
(PLX datasheet page 79 bit 29 and 28 for reset and reload eeprom config)

dave.fraser@baesystems.com a écrit :

> Is there any way of issuing a PCI reset (safely) without rebooting?  I am
> developing a peripheral device (using a pci card with an FPGA and a plx9080
> pci interface), and find that its local bus is prone to hanging up.  It
> would be nice if I could just reset the entire device via the PCI reset,
> without having to go through the hassle of a reboot.  Is this wishful
> thinking?
>
> - Dave
>
> ---------------------------------------------------------------------
>  Dave Fraser
>  Development Engineer
>  BAE Systems, Ferry Road,
>  Edinburgh, EH5 2XS
>  Tel: +44 131 3434729
>  Fax: +44 131 3434124
> ---------------------------------------------------------------------
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
__________________________________

Eric PENNAMEN
Service Etudes, R&D

NSI
Parc des Glaisins
6, avenue du Pré de Challes
BP 350
F-74943 ANNECY LE VIEUX Cedex

Téléphone   + 33 (0)4 50 09 46 30
Télécopie   + 33 (0)4 50 09 46 31

E-Mail :  Pennamen@nsi.fr
Internet : http://www.nsi.fr


