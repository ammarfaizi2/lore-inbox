Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263088AbRFECDb>; Mon, 4 Jun 2001 22:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263092AbRFECDV>; Mon, 4 Jun 2001 22:03:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45981 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263088AbRFECDN>;
	Mon, 4 Jun 2001 22:03:13 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15132.15829.322534.88410@pizda.ninka.net>
Date: Mon, 4 Jun 2001 19:03:01 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: David Woodhouse <dwmw2@infradead.org>, bjornw@axis.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush.
In-Reply-To: <3B1C1872.8D8F1529@mandrakesoft.com>
In-Reply-To: <13942.991696607@redhat.com>
	<3B1C1872.8D8F1529@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > David Woodhouse wrote:
 > > I was pointed at Documentation/DMA-mapping.txt but that doesn't seem very
 > > helpful - it's very PCI-specific, and a quick perusal of pci_dma_sync() on
 > > i386 shows that it doesn't do what's required anyway.
 > 
 > What should it do on i386?  mb()?

The x86 doesn't have dumb caches, therefore it really doesn't need to
flush anything.  Maybe a mb(), but that is it.

Later,
David S. Miller
davem@redhat.com
