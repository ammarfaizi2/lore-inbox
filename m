Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268172AbUHKToy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268172AbUHKToy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 15:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268192AbUHKToy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 15:44:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18901 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268172AbUHKTox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 15:44:53 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Wed, 11 Aug 2004 12:44:38 -0700
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>
References: <20040811192411.36763.qmail@web14927.mail.yahoo.com>
In-Reply-To: <20040811192411.36763.qmail@web14927.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408111244.38904.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 11, 2004 12:24 pm, Jon Smirl wrote:
> Jesse, did you notice that the quirk for tracking the boot video device
> is x86 only? I believe this needs to run on ia64 and x86_64 too. How do
> we want to do that? It will do the wrong thing on architectures that
> don't shadow video ROMs to C0000.

Yeah, but I don't know of any ia64 platforms that need the quirk.  All of them 
that I'm aware of use add-on boards.

Jesse
