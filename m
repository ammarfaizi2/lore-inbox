Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129305AbRBYOnc>; Sun, 25 Feb 2001 09:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129313AbRBYOnM>; Sun, 25 Feb 2001 09:43:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1543 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129305AbRBYOnF>; Sun, 25 Feb 2001 09:43:05 -0500
Subject: Re: [PATCH] s/isa//g in drivers/scsi/g_NCR5380.c and some cleanup (242)
To: rasmus@jaquet.dk (Rasmus Andersen)
Date: Sun, 25 Feb 2001 14:46:15 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010225154043.D764@jaquet.dk> from "Rasmus Andersen" at Feb 25, 2001 03:40:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14X2RG-0003D4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am sorry but have I inverted the arguments to the memcpy_*io calls?
> Or are you referring to something other than the arguments here?

You seem to have swapped the source/dest over in memcpy_toio cases and I need
to convince myself you did that correctly

