Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131174AbQLFCGE>; Tue, 5 Dec 2000 21:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131123AbQLFCFy>; Tue, 5 Dec 2000 21:05:54 -0500
Received: from anime.net ([63.172.78.150]:15876 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S131081AbQLFCFj>;
	Tue, 5 Dec 2000 21:05:39 -0500
Date: Tue, 5 Dec 2000 17:34:50 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <sl@fireplug.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
In-Reply-To: <E143THN-0000A1-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0012051733020.11374-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Alan Cox wrote:
> > Ditto, we have an adsl driver that we setup by overloading various otherwise
> > unused options in ifconfig (mem_start, io_addr etc) to do this. Cheaper and
> > faster than writing yet another ioctl using device configuration agent, but
> > distasteful non the less.
> Generic is not always good , thats why we have SIOCDEVPRIVATE. One thing Im
> pondering is if we should make the hardware config ioctl take a hardware type
> ident with each struct. That would help make all the ethernet agree, all the
> wan agree, all the ADSL agree without making a nasty mess.

Id be up for that, but its hard to standardize on IOCTLs without people
publishing their drivers, as long as people hide their code we dont know
what everyone else is doing config interface wise...

Lets see the code, people...

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
