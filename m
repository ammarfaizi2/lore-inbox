Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266824AbUHCUae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266824AbUHCUae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266770AbUHCUae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:30:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:40864 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266825AbUHCUaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:30:30 -0400
Subject: Re: [PATCH] [2/3] PCI quirks -- PPC.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       ralf@linux-mips.org
In-Reply-To: <1091554599.4383.1619.camel@hades.cambridge.redhat.com>
References: <1091554419.4383.1611.camel@hades.cambridge.redhat.com>
	 <1091554599.4383.1619.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1091564918.1922.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 06:28:39 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-04 at 03:36, David Woodhouse wrote:
> Remove up the PPC pcibios_fixups[] array. Remove the ifdefs on
> CONFIG_PPC_PMAC in the kernel PPC code, moving that stuff into
> pmac-specific files where it lives. Add a quirk for the CardBus
> controller on WindRiver SBC8260.

Ah nice ! I didn't notice we had those DECLARE_PCI_FIXUP_* macros 
nowdays !

Ben.

