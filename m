Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272551AbRIFUUI>; Thu, 6 Sep 2001 16:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272552AbRIFUT6>; Thu, 6 Sep 2001 16:19:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25106 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272551AbRIFUTs>; Thu, 6 Sep 2001 16:19:48 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Thu, 6 Sep 2001 21:23:43 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), wietse@porcupine.org (Wietse Venema),
        saw@saw.sw.com.sg (Andrey Savochkin),
        matthias.andree@gmx.de (Matthias Andree), ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010906221152.F13547@emma1.emma.line.org> from "Matthias Andree" at Sep 06, 2001 10:11:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15f5gd-0000Pu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 06 Sep 2001, Alan Cox wrote:
> > If you accept 10.0.0.1 from the outside you are leaking information. It
> 
> No, if you accept 10.*.*.* from the outside, your routers are broken.

Your router does not read mail RCPT headers.

RCPT root@[10.0.0.1]

can come from any ip address.

> Alan, SIOCGIFCONF is working sufficiently, it's SIOCGIFNETMASK that
> we're talking about. SIOCGIFNETMASK works properly on any other system
> or - as far as I can currently test - with my patch.

Then that is worth looking into.

Alan
