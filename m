Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264087AbRFNVrC>; Thu, 14 Jun 2001 17:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264080AbRFNVqo>; Thu, 14 Jun 2001 17:46:44 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:27284 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264087AbRFNVq2>;
	Thu, 14 Jun 2001 17:46:28 -0400
Message-ID: <3B2930B1.3E082883@mandrakesoft.com>
Date: Thu, 14 Jun 2001 17:46:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <15145.6960.267459.725096@pizda.ninka.net> <20010614213021.3814@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> While we are at it, I'd be really glad if we could agree on a
> way to abstract the current PIO scheme to understand the fact
> that any domain can actually have "legacy ISA-like" devices.

ioremap for outb/outw/outl.

IMHO of course.

I think rth requested pci_ioremap also...

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
