Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289802AbSBFIhT>; Wed, 6 Feb 2002 03:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290306AbSBFIg7>; Wed, 6 Feb 2002 03:36:59 -0500
Received: from ns.caldera.de ([212.34.180.1]:44422 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S289802AbSBFIg5>;
	Wed, 6 Feb 2002 03:36:57 -0500
Date: Wed, 6 Feb 2002 09:35:58 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, mmadore@turbolinux.com, linux-ia64@linuxia64.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [Linux-ia64] Proper fix for sym53c8xx_2 driver and dma64_addr_t
Message-ID: <20020206093558.A9445@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	"David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
	mmadore@turbolinux.com, linux-ia64@linuxia64.org,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20020205223804.A22012@caldera.de> <15456.21030.840746.209377@napali.hpl.hp.com> <20020206092129.A8739@caldera.de> <20020206.002906.94555802.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020206.002906.94555802.davem@redhat.com>; from davem@redhat.com on Wed, Feb 06, 2002 at 12:29:06AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 12:29:06AM -0800, David S. Miller wrote:
> What driver wants to get at this type and what are they using it
> for?  dma_addr_t should be used by every driver I am aware of
> except the clustering PCI cards I've been told about and that
> driver isn't in the kernel at this time.
> 
> So who needs it? :-)

The new sym53c8xx driver (sym2), and that one only if is actually is
configured for DAC-mode (SYM_CONF_DMA_ADDRESSING_MODE > 0).

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
