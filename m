Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132102AbRA2Oma>; Mon, 29 Jan 2001 09:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132093AbRA2OmM>; Mon, 29 Jan 2001 09:42:12 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:54641 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131378AbRA2OmD>; Mon, 29 Jan 2001 09:42:03 -0500
Date: Mon, 29 Jan 2001 08:41:48 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Martin Diehl <mdiehlcs@compuserve.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Robert Siemer <siemer@panorama.hadiko.de>,
        linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0
In-Reply-To: <Pine.LNX.4.21.0101291230070.29065-100000@notebook.diehl.home>
Message-ID: <Pine.LNX.3.96.1010129083911.27039F-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Martin Diehl wrote:
> I've the documentation for the SiS 5591/95 chipset which provides
> IRQ-routing using the 85C503 ISA bridge function function. This is
> the same vendor/device id as the pirq_sis*() rely on. According to this
> datasheet the pirq_sis*() thing is wrong, unless there are different
> chipsets using the same pci id's but behave differently. The thing went
> in around 2.4.0-test10 - but I'm unable to find a way to contact the
> author to check for different chip revisions e.g.

The specification that describes the link ("cookie") values in the
pirq table built by the BIOS is what needs to be described....  I'm not
sure you are looking at the correct docs.

And what what we're seeing in this thread, it looks like there are
two different types of SiS link values from two different BIOSen;
or perhaps one BIOS is using some of the link value bits for other
purposes.

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
