Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbQLFCZN>; Tue, 5 Dec 2000 21:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130188AbQLFCYx>; Tue, 5 Dec 2000 21:24:53 -0500
Received: from cr355197-a.poco1.bc.wave.home.com ([24.112.113.88]:41201 "EHLO
	whiskey.enposte.net") by vger.kernel.org with ESMTP
	id <S130139AbQLFCYl>; Tue, 5 Dec 2000 21:24:41 -0500
Date: Tue, 5 Dec 2000 17:55:17 -0800
From: Stuart Lynne <sl@fireplug.net>
To: Dan Hollis <goemon@anime.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
Message-ID: <20001205175517.I13431@fireplug.net>
Reply-To: Stuart Lynne <sl@fireplug.net>
In-Reply-To: <E143THN-0000A1-00@the-village.bc.nu> <Pine.LNX.4.30.0012051733020.11374-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0012051733020.11374-100000@anime.net>; from goemon@anime.net on Tue, Dec 05, 2000 at 05:34:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 05:34:50PM -0800, Dan Hollis wrote:
> On Wed, 6 Dec 2000, Alan Cox wrote:
> > > Ditto, we have an adsl driver that we setup by overloading various otherwise
> > > unused options in ifconfig (mem_start, io_addr etc) to do this. Cheaper and
> > > faster than writing yet another ioctl using device configuration agent, but
> > > distasteful non the less.
> > Generic is not always good , thats why we have SIOCDEVPRIVATE. One thing Im
> > pondering is if we should make the hardware config ioctl take a hardware type
> > ident with each struct. That would help make all the ethernet agree, all the
> > wan agree, all the ADSL agree without making a nasty mess.
> 
> Id be up for that, but its hard to standardize on IOCTLs without people
> publishing their drivers, as long as people hide their code we dont know
> what everyone else is doing config interface wise...
> 
> Lets see the code, people...

We are trying to get permission from the customer to release it.

-- 
                                            __O 
Fireplug - a Lineo company                _-\<,_ 
PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
Stuart Lynne <sl@fireplug.net>         www.lineo.com         604-461-7532
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
