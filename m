Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276987AbRJCVYp>; Wed, 3 Oct 2001 17:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276989AbRJCVYf>; Wed, 3 Oct 2001 17:24:35 -0400
Received: from ppp36.ts2.Gloucester.visi.net ([209.96.247.100]:30712 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S276987AbRJCVYW>; Wed, 3 Oct 2001 17:24:22 -0400
Date: Wed, 3 Oct 2001 17:23:04 -0400
From: Ben Collins <bcollins@debian.org>
To: Linux Bigot <linuxopinion@yahoo.com>
Cc: jes@sunsite.dk, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
Message-ID: <20011003172304.H319@visi.net>
In-Reply-To: <20011003153251.F319@visi.net> <20011003211108.16017.qmail@web14802.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011003211108.16017.qmail@web14802.mail.yahoo.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 02:11:08PM -0700, Linux Bigot wrote:
> Then why isn't there a call like pci_unmap_single()

include/asm-i386/pci.h:static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,


Uh, there is.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
