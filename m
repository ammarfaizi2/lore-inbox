Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291117AbSBSKtE>; Tue, 19 Feb 2002 05:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291126AbSBSKss>; Tue, 19 Feb 2002 05:48:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5901 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291117AbSBSKsa>; Tue, 19 Feb 2002 05:48:30 -0500
Subject: Re: Ess Solo-1 interrupt behaviour
To: root@ibe.miee.ru (Samium Gromoff)
Date: Tue, 19 Feb 2002 11:01:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202191252.g1JCqOR11998@ibe.miee.ru> from "Samium Gromoff" at Feb 19, 2002 03:52:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16d81Q-00008y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         I`ve recently spotted that a solo1 pci soundcard generates
> 16000+ interrupts/second with esd started idling.

Thats an esd bug. ESD tries to use ridiculously small fragment sizes
