Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRBYODK>; Sun, 25 Feb 2001 09:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbRBYODA>; Sun, 25 Feb 2001 09:03:00 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58374 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129225AbRBYOCm>; Sun, 25 Feb 2001 09:02:42 -0500
Subject: Re: [PATCH] s/isa//g in drivers/scsi/g_NCR5380.c and some cleanup (242)
To: rasmus@jaquet.dk (Rasmus Andersen)
Date: Sun, 25 Feb 2001 14:05:42 +0000 (GMT)
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010225145642.B764@jaquet.dk> from "Rasmus Andersen" at Feb 25, 2001 02:56:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14X1o6-00035n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (Does anybody know who the maintainer for this code is?)

There isnt one

> (An indication of how often this code path is used can be found in
> the fact that the previous define of NCR5380_write had its payload
> and address mixed up, probably making for wierd results should
> the code ever be executed.)

The driver works for me nicely. Im not convinced by the changes of direction
either. At least not without a detailed audit on the 2.2 code. Some of the
naming is very misleading in that driver

