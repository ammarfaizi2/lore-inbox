Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130539AbQLIXIu>; Sat, 9 Dec 2000 18:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130393AbQLIXIk>; Sat, 9 Dec 2000 18:08:40 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:12037 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130539AbQLIXI0>; Sat, 9 Dec 2000 18:08:26 -0500
Date: Sat, 9 Dec 2000 16:37:40 -0600
To: Pavel Machek <pavel@suse.cz>
Cc: Rasmus Andersen <rasmus@jaquet.dk>, perex@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove warning from drivers/net/hp100.c (240-test12-pre7)
Message-ID: <20001209163740.U6567@cadcamlab.org>
In-Reply-To: <20001208211908.D599@jaquet.dk> <20001209101924.A126@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001209101924.A126@bug.ucw.cz>; from pavel@suse.cz on Sat, Dec 09, 2000 at 10:19:24AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Pavel Machek]
> I'd say that warning is more acceptable than #ifdef... In cases where
> warnings can be eliminating without ifdefs, that's okay, but this...

In this case it is dead weight in the object file -- and for machines
that can least afford it (CONFIG_PCI=n is mostly for the low end,
right?).

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
