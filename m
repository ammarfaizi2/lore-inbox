Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVJSRG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVJSRG5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVJSRG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:06:57 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:13705 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751163AbVJSRG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:06:57 -0400
Date: Wed, 19 Oct 2005 11:06:55 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, acpi-devel@lists.sourceforge.net,
       greg@kroah.com, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [ACPI] Re: [Pcihpd-discuss] RE: [patch 2/2] acpi: add ability to derive irq when doing a surpriseremoval of an adapter
Message-ID: <20051019170655.GA17314@parisc-linux.org>
References: <59D45D057E9702469E5775CBB56411F190A57F@pdsmsx406> <1129053267.15526.9.camel@whizzy> <1129679877.30588.5.camel@whizzy> <200510190929.06728.bjorn.helgaas@hp.com> <1129740711.31966.21.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129740711.31966.21.camel@whizzy>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 09:51:51AM -0700, Kristen Accardi wrote:
> This seems like a good idea to me, if nobody objects to adding another
> field to pci_dev, I can change the patch to do this and resubmit. 

If you squeeze it in after rom_base_reg, it won't even take any more
space.  Assuming you'll be using a u8 for it, that is. (We only really
need three bits, right?  0-4)
