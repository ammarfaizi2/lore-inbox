Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288589AbSADKur>; Fri, 4 Jan 2002 05:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288594AbSADKuh>; Fri, 4 Jan 2002 05:50:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57359 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288589AbSADKuW>; Fri, 4 Jan 2002 05:50:22 -0500
Subject: Re: dd failure odd sectors, block addressing of 1024 question
To: adilger@turbolabs.com (Andreas Dilger)
Date: Fri, 4 Jan 2002 11:00:51 +0000 (GMT)
Cc: farmerduderl@yahoo.com (farmer dude), linux-kernel@vger.kernel.org
In-Reply-To: <20020103234558.K12868@lynx.no> from "Andreas Dilger" at Jan 03, 2002 11:45:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MS5j-0003Wx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> to store the MFT backup in the last sector of the partition) and the NT
> LDM driver which breaks when odd-sized volumes are concatenated together
> (one sector is missing out of the middle of the volume).

Also some IA64 stuff.

Switching to 512 byte basic addressing in 2.5 is probably doable if we
are going to have to break the 2^32 sector limit anyway
