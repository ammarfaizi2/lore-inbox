Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132279AbQLJTE1>; Sun, 10 Dec 2000 14:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132277AbQLJTER>; Sun, 10 Dec 2000 14:04:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58889 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132131AbQLJTEF>; Sun, 10 Dec 2000 14:04:05 -0500
Subject: Re: Got "VM: do_try_to_free_pages failed for xyz" in 2.2.18pre27
To: rbarnett@usc.edu (Ryan Barnett)
Date: Sun, 10 Dec 2000 18:35:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0012100943380.19986-100000@aludra.usc.edu> from "Ryan Barnett" at Dec 10, 2000 09:50:11 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145BJs-0006qK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is notice that the do_try_to_free_pages bug is still present in the
> latest 2.2 kernel, 2.2.18pre27.
> The error also occurs for other processes running on the system.  This was
> a test with ext3.

Journalling file systems will tend to trigger stuff. Im not fixing that for
2.2.18.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
