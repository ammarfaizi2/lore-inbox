Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUEKBvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUEKBvk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 21:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUEKBvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 21:51:40 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:50150 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S262006AbUEKBvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 21:51:39 -0400
Date: Mon, 10 May 2004 18:51:18 -0700
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Wim Coekaerts <wim.coekaerts@oracle.com>, cw@f00f.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040511015118.GA4589@ca-server1.us.oracle.com>
References: <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org> <20040510231146.GA5168@taniwha.stupidest.org> <20040510162818.376b4a55.akpm@osdl.org> <20040510233342.GA5614@taniwha.stupidest.org> <20040510165132.5107472e.akpm@osdl.org> <20040510235312.GA9348@taniwha.stupidest.org> <20040510171413.6c1699b8.akpm@osdl.org> <20040511002426.GD1105@ca-server1.us.oracle.com> <20040510181008.1906ea8a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510181008.1906ea8a.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > > Migrating away from this will require work from vendors, Oracle, PAM
> > > developers, /bin/login and /bin/su developers.  Until that has happened I
> > > think we should arrange for vendor kernels and kernel.org kernels to offer
> > > the same interfaces.
> > 
> > We have done the work and are going to be ok going forward to just use
> > hugeltbfs directly, just mounting it with right uid,gid. the main issue
> 
> err, so why did I just merge the hugetlb_shm_group patch?

because of what you mentioned. it takes a long time before that goes
out, it's not even tested, and it doesn't apply to those 1000's of
existing systems taht will break on upgrade.   exactly what you said, it
makes it possible to get to a different way smoothly in time. my
comments were not "we can use it today".

