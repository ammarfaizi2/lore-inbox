Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277894AbRJWQRZ>; Tue, 23 Oct 2001 12:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277893AbRJWQRP>; Tue, 23 Oct 2001 12:17:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39430 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277894AbRJWQQ7>; Tue, 23 Oct 2001 12:16:59 -0400
Subject: Re: [Lse-tech] Re: Preliminary results of using multiblock raw I/O
To: axboe@suse.de (Jens Axboe)
Date: Tue, 23 Oct 2001 17:23:27 +0100 (BST)
Cc: nagar@us.ibm.com (Shailabh Nagar), baettig@scs.ch (Reto Baettig),
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20011023084238.C638@suse.de> from "Jens Axboe" at Oct 23, 2001 08:42:38 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w4Kt-0006RM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> request the lower level driver can handle. This is typically 127kB, for
> SCSI it can be as much as 512kB currently and depending on the SCSI

We really btw should make scsi default to 128K - otherwise all the raid
stuff tends to go 127K, 1K, 127K, 1K and have to handle partial stripe
read/writes

