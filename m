Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278429AbRJXAuQ>; Tue, 23 Oct 2001 20:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278430AbRJXAuG>; Tue, 23 Oct 2001 20:50:06 -0400
Received: from mail126.mail.bellsouth.net ([205.152.58.86]:2427 "EHLO
	imf26bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278429AbRJXAty>; Tue, 23 Oct 2001 20:49:54 -0400
Message-ID: <3BD61063.37BFCB83@mandrakesoft.com>
Date: Tue, 23 Oct 2001 20:50:43 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benjamin LaHaise <bcrl@redhat.com>, Tim Hockin <thockin@sun.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, jes@trained-monkey.org
Subject: Re: HPT370/366 testers needed
In-Reply-To: <E15w8QQ-0000xh-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > the bios set it to something less than we expect it to, or to leave
> > this kind of pci hackery to the generic pci layer.  It's important to
> > note that quite a few drivers share this bug at present.  Cheers,
> 
> Time for pci_set_cacheline_size() ?

I have been contemplating this for quite a while.  Yes, we need it.

If there are no complaints nor better suggestions, I would prefer to use
the code in acenic.c / 8139cp.c as a base, since that code has been
stable for a little while.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

