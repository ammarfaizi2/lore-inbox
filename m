Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWDBSiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWDBSiM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 14:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWDBSiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 14:38:12 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:2207 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751329AbWDBSiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 14:38:12 -0400
From: David Brownell <david-b@pacbell.net>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [patch 2.6.16-git] dma doc updates
Date: Sun, 2 Apr 2006 08:21:43 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
References: <200604011021.53162.david-b@pacbell.net> <20060402025124.GI25945@granada.merseine.nu>
In-Reply-To: <20060402025124.GI25945@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604020921.44095.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 April 2006 6:51 pm, Muli Ben-Yehuda wrote:
> On Sat, Apr 01, 2006 at 10:21:52AM -0800, David Brownell wrote:
> 
> > +	int
> > +	dma_map_sg(struct device *dev, struct scatterlist *sg,
> > +		int nents, enum dma_data_direction direction)
> 
> While you're at it, care to s/enum dma_data_direction/int/? some archs
> use one and some use the other, and there was weak consensus that int
> is better.

Nah.  That patch was just to _clarify_ things not make API changes.
That particular text was just being indented for readability.

Plus, I won't join a consensus to needlessly prevent compilers from
reporting illegal parameters.

- Dave
