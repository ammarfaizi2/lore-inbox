Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130349AbRAJAmQ>; Tue, 9 Jan 2001 19:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130191AbRAJAmI>; Tue, 9 Jan 2001 19:42:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17680 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130349AbRAJAlt>; Tue, 9 Jan 2001 19:41:49 -0500
Subject: Re: Compatibility issue with 2.2.19pre7
To: mantel@suse.de (Hubert Mantel)
Date: Wed, 10 Jan 2001 00:43:42 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20010110013755.D13955@suse.de> from "Hubert Mantel" at Jan 10, 2001 01:37:55 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14G9Me-0007ou-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is this part of 2.2.19pre7 really a good idea? Even in 2.4.0 the size
> field is still a short.

It needs to change in 2.4 as well. The cast of data to a struct isnt portable
to all architectures.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
