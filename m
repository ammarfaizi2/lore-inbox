Return-Path: <linux-kernel-owner+w=401wt.eu-S932737AbWLSJ5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbWLSJ5E (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932742AbWLSJ5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:57:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1129 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932737AbWLSJ5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:57:01 -0500
Date: Tue, 19 Dec 2006 10:57:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/pci/quirks.c: cleanup
Message-ID: <20061219095700.GF6993@stusta.de>
References: <20061219041315.GE6993@stusta.de> <20061219085249.GL21070@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219085249.GL21070@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 01:52:49AM -0700, Matthew Wilcox wrote:
> On Tue, Dec 19, 2006 at 05:13:15AM +0100, Adrian Bunk wrote:
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci );
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci );
> 
> Why all the crazy spacing?
> 
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5597, quirk_nopcipci);

I also saw this, but it's consistent through the file.

But if it's agreed upon, I can also change this.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

