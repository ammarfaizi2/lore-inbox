Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRAKMxZ>; Thu, 11 Jan 2001 07:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131568AbRAKMxP>; Thu, 11 Jan 2001 07:53:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35081 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129846AbRAKMw6>; Thu, 11 Jan 2001 07:52:58 -0500
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 11 Jan 2001 12:54:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <93jrj8$1jc$1@penguin.transmeta.com> from "Linus Torvalds" at Jan 11, 2001 12:41:12 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GhFE-0002AZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	#define HAVE_FXSR	(cpu_has_fxsr)
> 	#define HAVE_XMM	(cpu_has_xmm)
> 
> I'm surprised actually - the same CR4 tests are in newer 2.2.x kernels,
> I think. (And in 2.2.x kernels, the above "cpu_has_xxx" do _not_ work

Nope. 2.2 doesnt have XMM/FXSR support. There are add on patches for it but
I don't plan to merge them

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
