Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273315AbRIUMDO>; Fri, 21 Sep 2001 08:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273309AbRIUMDF>; Fri, 21 Sep 2001 08:03:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1555 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273470AbRIUMCz>; Fri, 21 Sep 2001 08:02:55 -0400
Subject: Re: [PATCH] parport_pc.c PnP BIOS sanity check
To: ignacio@openservices.net (Ignacio Vazquez-Abrams)
Date: Fri, 21 Sep 2001 13:07:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109210209520.21008-100000@terbidium.openservices.net> from "Ignacio Vazquez-Abrams" at Sep 21, 2001 02:11:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kP5q-0008BX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> therefore a value of 0 is representative of no value whatsoever.

This has been unsafe since about 1995, when DMA 0 became available as PC's
stopped using the ISA DMA engine for memory refresh (a very neat original PC
hack)

Alan
