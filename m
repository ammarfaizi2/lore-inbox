Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130541AbQLFBuh>; Tue, 5 Dec 2000 20:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130756AbQLFBu2>; Tue, 5 Dec 2000 20:50:28 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8196 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130541AbQLFBuR>; Tue, 5 Dec 2000 20:50:17 -0500
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
To: sl@fireplug.net
Date: Wed, 6 Dec 2000 01:21:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001205145535.A13431@fireplug.net> from "Stuart Lynne" at Dec 05, 2000 02:55:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E143THN-0000A1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ditto, we have an adsl driver that we setup by overloading various otherwise
> unused options in ifconfig (mem_start, io_addr etc) to do this. Cheaper and
> faster than writing yet another ioctl using device configuration agent, but
> distasteful non the less.

Generic is not always good , thats why we have SIOCDEVPRIVATE. One thing Im
pondering is if we should make the hardware config ioctl take a hardware type
ident with each struct. That would help make all the ethernet agree, all the
wan agree, all the ADSL agree without making a nasty mess.

> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
