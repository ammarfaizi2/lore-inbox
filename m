Return-Path: <linux-kernel-owner+w=401wt.eu-S964848AbXASGGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbXASGGR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 01:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbXASGGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 01:06:17 -0500
Received: from cnc.isely.net ([64.81.146.143]:39736 "EHLO cnc.isely.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964848AbXASGGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 01:06:17 -0500
Date: Fri, 19 Jan 2007 00:05:58 -0600 (CST)
From: Mike Isely <isely@isely.net>
Reply-To: Mike Isely <isely@pobox.com>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
cc: Randy Dunlap <randy.dunlap@oracle.com>,
       "Robert P. J. Day" <rpjday@mindspring.com>, video4linux-list@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, Mike Isely at pobox <isely@pobox.com>
Subject: Re: [PATCH 2.6.20-rc5 2/4] pvrusb2: Use ARRAY_SIZE macro
In-Reply-To: <20070116190738.GD718@Ahmed>
Message-ID: <Pine.LNX.4.64.0701190003020.26643@cnc.isely.net>
References: <20070116080136.GA30133@Ahmed>
 <Pine.LNX.4.64.0701160334350.20244@CPE00045a9c397f-CM001225dbafb6>
 <20070116101633.39e57884.randy.dunlap@oracle.com> <20070116190738.GD718@Ahmed>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Ahmed S. Darwish wrote:

> On Tue, Jan 16, 2007 at 10:16:33AM -0800, Randy Dunlap wrote:
> > On Tue, 16 Jan 2007 03:36:16 -0500 (EST) Robert P. J. Day wrote:
> > 
> > > On Tue, 16 Jan 2007, Ahmed S. Darwish wrote:
> > > 
> > > > Use ARRAY_SIZE macro in pvrusb2-hdw.c file
> > > >
> > > > Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> > > 
> > > ... snip ...
> > > 
> > > i'm not sure it's worth submitting multiple patches to convert code
> > > expressions to the ARRAY_SIZE() macro since i was going to wait for
> > > the next kernel release, and do that in one fell swoop with a single
> > > patch.
> > > 
> > > but if people higher up the food chain think it's a better idea to do
> > > it a little at a time, that's fine.
> > 
> > I'm not strictly on the food chain, but these 4 patches to
> > pvrusb2 should have been sent as one patch IMO.
> 
> Here's the same patch in one file as suggested.
> 
> A patch to use ARRAY_SIZE macro when appropriate. 
> 
> Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> ---

Ahmed:

I've pulled your patch into my driver source and will propagate it up 
appropriately as part of the next batch of pvrusb2 changes to come out 
of the v4l-dvb repository.

  -Mike


-- 
                        |         Mike Isely          |     PGP fingerprint
     Spammers Die!!     |                             | 03 54 43 4D 75 E5 CC 92
                        |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |                             |
