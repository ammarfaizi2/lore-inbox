Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBLKgV>; Mon, 12 Feb 2001 05:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130522AbRBLKgL>; Mon, 12 Feb 2001 05:36:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19985 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129253AbRBLKgE>; Mon, 12 Feb 2001 05:36:04 -0500
Subject: Re: ulimit syscall
To: philips@iph.to (Philips)
Date: Mon, 12 Feb 2001 10:36:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3A87BBAB.22721100@iph.to> from "Philips" at Feb 12, 2001 12:32:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SGL5-0006ee-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello All!
> 	I'm running 2.2.18 kernel and as I see ulimit not implemented in 2.2
> 	Is 2.4 has ulimit syscall implementation?

Both 2.2 and 2.4 do - but via the rather more flexible rlimit() interface in
the kernel. The C library will do ulimit->rlimit translation
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
