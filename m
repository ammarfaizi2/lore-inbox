Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131380AbRBMN07>; Tue, 13 Feb 2001 08:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131418AbRBMN0t>; Tue, 13 Feb 2001 08:26:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16649 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131380AbRBMN0e>; Tue, 13 Feb 2001 08:26:34 -0500
Subject: Re: Linux 2.2.19pre10
To: cr@sap.com (Christoph Rohland)
Date: Tue, 13 Feb 2001 13:27:06 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        cowboy@vnet.ibm.com (Richard A Nelson), linux-kernel@vger.kernel.org
In-Reply-To: <m37l2u7ltg.fsf@linux.local> from "Christoph Rohland" at Feb 13, 2001 02:29:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SfU5-0001mT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, I understand that. But I never got any note that my fix is broken
> and I still do not understand what's the concern. 

Unless Im misreading the code the segment you poke at has potentially been
freed before it is written too.
