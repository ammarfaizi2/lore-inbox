Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbRBMSXl>; Tue, 13 Feb 2001 13:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129569AbRBMSXb>; Tue, 13 Feb 2001 13:23:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46346 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129285AbRBMSX2>; Tue, 13 Feb 2001 13:23:28 -0500
Subject: Re: [Patch] correct tmpfs link count for directories
To: cr@sap.com (Christoph Rohland)
Date: Tue, 13 Feb 2001 18:23:53 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        andreas.koenig@anima.de (Andreas J. Koenig)
In-Reply-To: <m3zofq3268.fsf@linux.local> from "Christoph Rohland" at Feb 13, 2001 06:47:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Sk7H-0002TY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The attached patch makes tmpfs behave more like other fs's. Apparently
> perl expects this.

A few apps assume this. All of them are buggy. I'll apply the patch.
