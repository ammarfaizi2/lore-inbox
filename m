Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUHCXky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUHCXky (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 19:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUHCXky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 19:40:54 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:64409 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S264795AbUHCXkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 19:40:46 -0400
Subject: Re: [PATCH] [2/3] PCI quirks -- PPC.
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       ralf@linux-mips.org
In-Reply-To: <1091564918.1922.9.camel@gaston>
References: <1091554419.4383.1611.camel@hades.cambridge.redhat.com>
	 <1091554599.4383.1619.camel@hades.cambridge.redhat.com>
	 <1091564918.1922.9.camel@gaston>
Content-Type: text/plain
Message-Id: <1091576440.12594.139.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 04 Aug 2004 00:40:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-04 at 06:28 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2004-08-04 at 03:36, David Woodhouse wrote:
> > Remove up the PPC pcibios_fixups[] array. Remove the ifdefs on
> > CONFIG_PPC_PMAC in the kernel PPC code, moving that stuff into
> > pmac-specific files where it lives. Add a quirk for the CardBus
> > controller on WindRiver SBC8260.
> 
> Ah nice ! I didn't notice we had those DECLARE_PCI_FIXUP_* macros 
> nowdays !

We don't. That was patch 1 of the 3 :)

-- 
dwmw2


