Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269725AbUHZWJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269725AbUHZWJS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269688AbUHZWIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:08:36 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:59403 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S269712AbUHZWFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:05:14 -0400
Date: Fri, 27 Aug 2004 00:05:01 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: netfilter IPv6 support
Message-ID: <20040826220501.GA564@alpha.home.local>
References: <1093546367.3497.23.camel@hostmaster.org> <20040826130024.6ff83dff.davem@redhat.com> <1093555510.3497.33.camel@hostmaster.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093555510.3497.33.camel@hostmaster.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 11:25:10PM +0200, Thomas Zehetbauer wrote:
> On Don, 2004-08-26 at 13:00 -0700, David S. Miller wrote:
> > Stateful netfilter is not there because it's a total waste
> > to completely duplicate all of the connection tracking et al.
> > code into ipv6 counterparts when %80 of the code is roughly
> > the same.  People are working on a consolidation of these
> > things so that there is no code duplication but it is a lot
> > of work and there are bigger fires to put out at the moment.
> 
> Of course it's a waste to duplicate the code but as far as I remember
> the status of netfilter for IPv6 has not changed for almost a year. As
> said there is still not even the basic REJECT target available.

These features are available in patch-o-matic-ng. They're not in mainline
because the netfilter team only pushes well tested and non-intrusive changes.
But there are lots of people using features from patch-o-matic in production.
You can get those here :

    ftp://ftp.netfilter.org/pub/patch-o-matic-ng/

Please also take a look at the mailing list archives since it's an area
which is currently moving :
 
    http://marc.theaimsgroup.com/?l=netfilter-devel

Regards,
Willy

