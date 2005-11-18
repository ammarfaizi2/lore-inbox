Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161263AbVKRVwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbVKRVwM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbVKRVwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:52:12 -0500
Received: from havoc.gtf.org ([69.61.125.42]:54174 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161263AbVKRVwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:52:11 -0500
Date: Fri, 18 Nov 2005 16:52:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
Message-ID: <20051118215209.GA9425@havoc.gtf.org>
References: <437D2DED.5030602@pobox.com> <Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 10:50:04PM +0100, Bogdan Costescu wrote:
> On Thu, 17 Nov 2005, Jeff Garzik wrote:
> 
> > See if you can give the latest git tree a try (what will be 
> > 2.6.15-rc1-git6, later tonight).  I think I've killed most of the 
> > sata_mv bugs, and have it working here on both 50xx and 60xx.
> 
> I can report success as well on a 504x. However it only works without 
> MSI, with MSI I get the same insmod blocked in D state as before.

Yes, for both 50xx and 60xx, I had to turn off MSI in order to get
sata_mv to work...

	Jeff



