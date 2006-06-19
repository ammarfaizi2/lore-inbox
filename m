Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWFSLUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWFSLUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 07:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWFSLUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 07:20:05 -0400
Received: from smtp10.orange.fr ([193.252.22.21]:2366 "EHLO smtp10.orange.fr")
	by vger.kernel.org with ESMTP id S932239AbWFSLUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 07:20:03 -0400
X-ME-UUID: 20060619112002602.930A7280014A@mwinf1007.orange.fr
Subject: Re: [RFC] Whitelist chipsets supporting MSI and check
	Hyper-transport capabilities
From: Xavier Bestel <xavier.bestel@free.fr>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Brice Goglin <brice@myri.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060617050524.GX2387@parisc-linux.org>
References: <4493709A.7050603@myri.com>
	 <20060617050524.GX2387@parisc-linux.org>
Content-Type: text/plain
Message-Id: <1150715995.14284.10.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 19 Jun 2006 13:19:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-17 at 07:05, Matthew Wilcox wrote:
> On Fri, Jun 16, 2006 at 11:01:46PM -0400, Brice Goglin wrote:
> > We introduce whitelisting of chipsets that are known to support MSI and
> > keep the existing backlisting to disable MSI for other chipsets. When it
> > is unknown whether the root chipset support MSI or not, we disable MSI
> > by default except if pci=forcemsi was passed.
> 
> I think that's a bad idea.  Blacklisting is the better idea in the long-term.

I think the option adopted elsewhere is: whitelist for old chipsets, and
blacklist for new chipsets. You just have to decide for a good date to
separate "old" and "new" to minimize the lists size.

	Xav

