Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132503AbRDGEP1>; Sat, 7 Apr 2001 00:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132508AbRDGEPS>; Sat, 7 Apr 2001 00:15:18 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:35845
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132503AbRDGEPJ>; Sat, 7 Apr 2001 00:15:09 -0400
Date: Fri, 6 Apr 2001 21:14:36 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: linux-2.4.3-ac3.tfhsio2/drivers/ide/Makefile
Message-ID: <Pine.LNX.4.10.10104062111270.2280-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

Since this is no more than a chipset that is identical to piix.c
Why is it setup as a loadable object?

obj-$(CONFIG_BLK_DEV_IT8172)    += it8172.o

and not like below?

ide-obj-$(CONFIG_BLK_DEV_IT8172)       += it8172.o

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

