Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129781AbQJaXCW>; Tue, 31 Oct 2000 18:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129829AbQJaXCM>; Tue, 31 Oct 2000 18:02:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64372 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129781AbQJaXCE>; Tue, 31 Oct 2000 18:02:04 -0500
Subject: Re: 2.2.18Pre Lan Performance Rocks!
To: jmerkey@timpanogas.org (Jeff V. Merkey)
Date: Tue, 31 Oct 2000 23:02:06 +0000 (GMT)
Cc: ak@suse.de (Andi Kleen), mingo@elte.hu, pavel@suse.cz (Pavel Machek),
        linux-kernel@vger.kernel.org
In-Reply-To: <39FF4B99.1746E06E@timpanogas.org> from "Jeff V. Merkey" at Oct 31, 2000 03:45:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qkPv-0008Nf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One more optimization it has.  NetWare never "calls" functions in the
> kernel.  There's a template of register assignments in between kernel
> modules that's very strict (esi contains a WTD head, edi has the target
> thread, etc.) and all function calls are jumps in a linear space. 

What if I jump to an invalid address - does it crash ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
