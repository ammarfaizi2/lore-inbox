Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289507AbSAJPjt>; Thu, 10 Jan 2002 10:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289508AbSAJPji>; Thu, 10 Jan 2002 10:39:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27914 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289507AbSAJPjc>; Thu, 10 Jan 2002 10:39:32 -0500
Subject: Re: HPT370 controller set wrong udma mode
To: kiza@gmx.net (Oliver Feiler)
Date: Thu, 10 Jan 2002 15:51:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020110160718.A296@gmxpro.net> from "Oliver Feiler" at Jan 10, 2002 04:07:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OhTs-0004iz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	My onboard (Epox 8KTA3+) HPT370 controller seems to set the wrong udma 
> transfer mode for the attached drive. Resulting in BadCRC errors. The drive 
> attached is an IBM DJSA-205 2.5" drive. It can do udma4 max.

Make sure you use the Andre Hedrick ide patches with the HPT 370. That fixed
all my problems with them at least
	(http://www.linux-ide.org)
