Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129591AbQLFNcL>; Wed, 6 Dec 2000 08:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLFNcB>; Wed, 6 Dec 2000 08:32:01 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:60690 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129725AbQLFNbj>; Wed, 6 Dec 2000 08:31:39 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200012061301.eB6D17B08279@devserv.devel.redhat.com>
Subject: Re: That horrible hack from hell called A20
To: cate@student.ethz.ch (Giacomo Catenazzi)
Date: Wed, 6 Dec 2000 08:01:06 -0500 (EST)
Cc: hpa@transmeta.com (H. Peter Anvin),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        alan@redhat.com (Alan Cox)
In-Reply-To: <3A2E345C.EE6F5640@student.ethz.ch> from "Giacomo Catenazzi" at Dec 06, 2000 01:43:08 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> INT 15-2401 disable A20
> INT 15-2402 query status A20
> INT 15-2403 query A20 support (kdb or port 92)
> 
> IBM classifies these functions as optional, but it is enabled on a lot
> of
> new BIOS, no know conflicts, thus we can call this function to enable
> A20,
> check the result and only after failure we can try the old methods.

I trust Linus over BIOS vendors, every single time. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
