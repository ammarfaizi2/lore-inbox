Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVBWSNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVBWSNj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 13:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVBWSNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 13:13:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61625 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261519AbVBWSNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 13:13:33 -0500
Date: Wed, 23 Feb 2005 04:06:08 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>,
       Vasily Averin <vvs@sw.ru>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       "Mukker, Atul" <Atulm@lsil.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>
Subject: v2.4 megaraid2 update Re: [PATCH] Prevent NMI oopser
Message-ID: <20050223070607.GA8812@dmt.cnet>
References: <41F5FC96.2010103@sw.ru> <20050131231752.GA17126@logos.cnet> <42011EFA.10109@sw.ru> <20050202190626.GB18763@lists.us.dell.com> <42012ACC.4090806@sw.ru> <20050202201914.GC18763@lists.us.dell.com> <20050207202745.GA19104@kmv.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207202745.GA19104@kmv.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

As the megaraid2 maintainers dont seem to care about v2.4 mainline at all, completly 
ignoring my requests to fix the NMI oopser bug for several months, I'm applying the RHEL3 
update + inline reordering, which should do it.

At this point I'm quite sure they wont answer this message either.  :( 

Thanks Vasily and Andrey.

On Mon, Feb 07, 2005 at 11:27:45PM +0300, Andrey J. Melnikoff (TEMHOTA) wrote:
> Hi Matt, Marcelo!
>  On Wed, Feb 02, 2005 at 02:19:14PM -0600, Matt Domsch wrote next:
> 
> > On Wed, Feb 02, 2005 at 10:32:28PM +0300, Vasily Averin wrote:
> > > >As a hack, one could #define inline /*nothing*/ in megaraid2.h to
> > > >avoid this, but it would be nice if the functions could all get
> > > >reordered such that inlining works properly, and the need for function
> > > >declarations in megaraid2.h would disappear completely.
> > > 
> > > 
> > > Could you fix it by additional patch? Or you going to prepare a new one?
> 
> Any chance to include this two patches before 2.4.30 release?
> 
> Vasily Averin patch:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110737085714273&w=2
> And my (incremental) patch:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110738438005846&w=2
