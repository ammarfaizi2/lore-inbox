Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbRAKMmx>; Thu, 11 Jan 2001 07:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130234AbRAKMmo>; Thu, 11 Jan 2001 07:42:44 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30729 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130154AbRAKMmb>; Thu, 11 Jan 2001 07:42:31 -0500
Subject: Re: 2.4.0-ac6: mm/vmalloc.c compile error
To: fdavis112@juno.com (Frank Davis)
Date: Thu, 11 Jan 2001 12:44:22 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20010111.002835.-160337.1.fdavis112@juno.com> from "Frank Davis" at Jan 11, 2001 12:28:28 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Gh5c-00029V-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   The following error occurred while compiling 2.4.0-ac6..The strange
> thing is that I checked mm/vmalloc.c (line 188, and the entire file) and
> didn't see PKMAP_BASE mentioned. My guess is that there is a problem with
> one of the header files.

Its defined in asm/highmem.h/ Probabyl a missing include if building a bigmem
kenrel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
