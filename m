Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283294AbRK2QXA>; Thu, 29 Nov 2001 11:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283307AbRK2QWu>; Thu, 29 Nov 2001 11:22:50 -0500
Received: from jik-0.dsl.speakeasy.net ([66.92.77.120]:61704 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id <S283294AbRK2QWj>; Thu, 29 Nov 2001 11:22:39 -0500
Date: Thu, 29 Nov 2001 11:22:35 -0500
Message-Id: <200111291622.fATGMZw27075@jik.kamens.brookline.ma.us>
X-mailer: xrn 9.03-beta-12
To: Daniel Stodden <stodden@in.tum.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <fa.eqan66v.1hs2ql@ifi.uio.no>
From: jik@kamens.brookline.ma.us (Jonathan Kamens)
Subject: Re: where the hell is pci_read_config_xyz defined
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered exactly this problem recently.  I finally figured out
that the trick is that the pci_read_config_* and pci_write_config_*
functions are defined by a macro in drivers/pci/pci.c.  Search for
"PCI_OP" in that file and you'll see what I mean.
