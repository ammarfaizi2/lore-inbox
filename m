Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbQLANLl>; Fri, 1 Dec 2000 08:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129689AbQLANLb>; Fri, 1 Dec 2000 08:11:31 -0500
Received: from 13dyn218.delft.casema.net ([212.64.76.218]:5642 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129414AbQLANLX>; Fri, 1 Dec 2000 08:11:23 -0500
Date: Fri, 1 Dec 2000 13:40:49 +0100 (CET)
From: Patrick van de Lageweg <patrick@bitwizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rogier Wolff <wolff@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] rio
Message-ID: <Pine.LNX.4.21.0012011334440.5601-100000@panoramix.bitwizard.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi alan,

This patches fixes several isues with the rio driver:

 - Implemented breaks
 - Fixed a DCD up/down crash
 - Added kmalloc return value check

Sorry for the late moment we submit this: the DCD bug was very, very hard
to find.

	Patrick

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
