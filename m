Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129154AbRBLX2M>; Mon, 12 Feb 2001 18:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129162AbRBLX2D>; Mon, 12 Feb 2001 18:28:03 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8198 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129154AbRBLX1v>; Mon, 12 Feb 2001 18:27:51 -0500
Subject: Re: LILO and serial speeds over 9600
To: hpa@transmeta.com (H. Peter Anvin)
Date: Mon, 12 Feb 2001 23:27:53 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        Werner.Almesberger@epfl.ch (Werner Almesberger),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A886FAC.C47465A7@transmeta.com> from "H. Peter Anvin" at Feb 12, 2001 03:20:12 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SSNw-0008To-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Depends on what the client can handle.  For the kernel, that might be
> true, but for example a boot loader may only have a few K worth of buffer
> space.

That same constraint is true of any UDP protocol too, and indeed any protocol
not entirely based on FEC (which rather rules out ethernet based solutions)

You also dont need much buffering for a smart embedded stack, its no secret
that some embedded tcps dont buffer the data but pointers to constant data and
values for only non constant objects. You really can make a minimal TCP very
low resource.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
