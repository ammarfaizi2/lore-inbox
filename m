Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268168AbUIGPV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268168AbUIGPV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268224AbUIGPTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:19:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:41905 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268339AbUIGPOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:14:32 -0400
Date: Tue, 7 Sep 2004 17:10:22 +0200
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040907151022.GA32287@wotan.suse.de>
References: <20040903080058.GB2402@wotan.suse.de> <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de> <20040907134517.GA1016@mellanox.co.il> <20040907141524.GA13862@wotan.suse.de> <20040907142530.GB1016@mellanox.co.il> <20040907142945.GB20981@wotan.suse.de> <20040907143702.GC1016@mellanox.co.il> <20040907144452.GC20981@wotan.suse.de> <20040907144543.GA1340@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907144543.GA1340@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 05:45:43PM +0300, Michael S. Tsirkin wrote:
> > > > but I cannot think of a good alternative. 
> > > > 
> > > 
> > > Maybe one entry point with a flag?
> > 
> > That would be IMHO far uglier than two. 
> > 
> > -Andi
> >
> 
> What would be a good name? ioctl32/ioctl64? ioctl_compat/ioctl_native?

Later two sound ok to me.

-Andi
