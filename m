Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271537AbRINXPI>; Fri, 14 Sep 2001 19:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271514AbRINXO6>; Fri, 14 Sep 2001 19:14:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59150 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271522AbRINXOo>; Fri, 14 Sep 2001 19:14:44 -0400
Subject: Re: VIA IDE and SMP do not work together (2.2.19   ide patch)
To: jurij@euroseek.com
Date: Sat, 15 Sep 2001 00:19:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200109141817.UAA00924@w2.euroseek.net> from "jurij@euroseek.com" at Sep 14, 2001 08:17:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15i2En-00018T-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tyan S2507 Tiger 230 2-processor motherboard with a VIA Apollo
> Pro 133A chipset (particularly, VIA IDE controller VT82C686B). 
> We have tried 2.2.19 kernel with ide patch dated 05042001 from 

VIA SMP really wants a 2.4 kernel. There are several reasons for that
including APIC knowledge, up to date IDE UDMA drivers and also the VIA
chipset bug workaround for the corruption problem
