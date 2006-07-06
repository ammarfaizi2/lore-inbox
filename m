Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWGFXll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWGFXll (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWGFXll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:41:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:59623 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751052AbWGFXlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:41:40 -0400
Subject: Re: [PATCH 38 of 39] IB/ipath - More changes to support InfiniPath
	on PowerPC 970 systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <1152228867.24748.3.camel@localhost.localdomain>
References: <c22b6c244d5db77f7b1d.1151617289@eng-12.pathscale.com>
	 <1152225421.9862.12.camel@localhost.localdomain>
	 <1152228867.24748.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 09:39:05 +1000
Message-Id: <1152229145.9862.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 16:34 -0700, Bryan O'Sullivan wrote:
> On Fri, 2006-07-07 at 08:37 +1000, Benjamin Herrenschmidt wrote:
> 
> > > +int ipath_unordered_wc(void)
> > > +{
> > > +	return 1;
> > > +}
> > 
> > How is the above providing any kind of serialisation ?
> 
> It's not intended to; it tells the *caller* whether to do it.

Ah ok. What barrier do you use for that ?

Ben.

