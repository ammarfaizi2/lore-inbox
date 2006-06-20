Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWFTRuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWFTRuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWFTRuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:50:55 -0400
Received: from lixom.net ([66.141.50.11]:51928 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1750740AbWFTRuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:50:55 -0400
Date: Tue, 20 Jun 2006 12:50:07 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, paulus@samba.org, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [Cbe-oss-dev] [patch 01/20] cell: add RAS support
Message-ID: <20060620175007.GE4845@pb15.lixom.net>
References: <20060619183315.653672000@klappe.arndb.de> <20060619183404.144740000@klappe.arndb.de> <20060620154304.GD4845@pb15.lixom.net> <200606201826.54290.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606201826.54290.arnd@arndb.de>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 06:26:53PM +0200, Arnd Bergmann wrote:
> On Tuesday 20 June 2006 17:43, Olof Johansson wrote:
> > 
> > > This is a first version of support for the Cell BE "Reliability,
> > > Availability and Serviceability" features.
> > 
> > Does it really make sense to do this under a config option? I don't see
> > why anyone would not want to know that their machine is about to melt.
> > 
> You can only have that when running on bare metal. Machines that run
> on a hypervisor can't run that code.

Well, it's harmless to build it in even on hypervisor systems, right?

> It probably makes sense to auto-select that option for CONFIG_CELL_BLADE
> though.

Sounds like a reasonable trade-off.

-Olof
