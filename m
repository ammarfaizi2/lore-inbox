Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWGROJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWGROJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 10:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWGROJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 10:09:11 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:65259 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S932229AbWGROJK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 10:09:10 -0400
Date: Tue, 18 Jul 2006 17:09:06 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Jon Mason <jdmason@us.ibm.com>,
       linux-kernel@vger.kernel.org, konradr@redhat.com
Subject: Re: [discuss] [PATCH 1/2] x86_64: Calgary IOMMU - Multi-Node NULL pointer dereference fix
Message-ID: <20060718140906.GA10011@rhun.ibm.com>
References: <20060717231836.GD5363@us.ibm.com> <200607181550.57382.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607181550.57382.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2006 at 03:50:57PM +0200, Andi Kleen wrote:
> On Tuesday 18 July 2006 01:18, Jon Mason wrote:
> > Hey Andi,
> >
> > Calgary hits a NULL pointer dereference when booting in a multi-chassis
> > NUMA system.  See Redhat bugzilla number 198498, found by Konrad
> > Rzeszutek (konradr@redhat.com).
> 
> The patch doesn't apply at all to rc2.
>
> Also where is 2/2 ? I only see 1/2 

Hmpf, there were two Calgary patches, both mistakenly labeled
1/2. This is actually the second one. When applied in order, both
apply to today's head.

Sorry about the confusion, please let us know if you want a resend. I
guess Jon got a smidgen too excited about OLS :-)

Cheers,
Muli
