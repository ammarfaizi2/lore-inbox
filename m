Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292525AbSBTVvS>; Wed, 20 Feb 2002 16:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292527AbSBTVvI>; Wed, 20 Feb 2002 16:51:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35082 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292526AbSBTVvC>;
	Wed, 20 Feb 2002 16:51:02 -0500
Message-ID: <3C741A44.94FE4F56@mandrakesoft.com>
Date: Wed, 20 Feb 2002 16:51:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org> <20020220103539.B32211@vger.timpanogas.org> <3C73DC34.E83CCD35@mandrakesoft.com> <20020220.093034.112623671.davem@redhat.com> <20020220110004.A32431@vger.timpanogas.org> <20020220145449.A1102@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> regions of memory.  I would propose that the maintainer of
> vmalloc.c look at using 48 bit PTE entries or some other solution
> as a way to alloc larger virtual address frames when the system has
> a lot of physical memory.  It's seems pretty lame to me for a machine
> with 2 GB of physical memory not to have at lest 256 MB of address space
> left over for address mapping.

Instead of constantly trying to map >32-bit addresses onto 32-bit
processors, why not just get a 64-bit processor?

One constantly runs into limitations with highmem...

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
