Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265063AbUEKXYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUEKXYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbUEKXYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:24:37 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:19140 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S265064AbUEKXYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:24:25 -0400
Date: Tue, 11 May 2004 08:12:07 -0700
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: hch@infradead.org
Cc: Andrew Morton <akpm@osdl.org>, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040511151206.GK11353@ca-server1.us.oracle.com>
References: <20040510150203.3257ccac.akpm@osdl.org> <20040510231146.GA5168@taniwha.stupidest.org> <20040510162818.376b4a55.akpm@osdl.org> <20040510233342.GA5614@taniwha.stupidest.org> <20040510165132.5107472e.akpm@osdl.org> <20040510235312.GA9348@taniwha.stupidest.org> <20040510171413.6c1699b8.akpm@osdl.org> <20040511002426.GD1105@ca-server1.us.oracle.com> <20040510181008.1906ea8a.akpm@osdl.org> <20040511015118.GA4589@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511015118.GA4589@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oh and for what it's worth, I didn't like the shmgid solution either, I
brought up rlmits first iirc. if there is something better great, but as
that was not going anywhere and this is... 

let's see if wli can make things work correctly with physdical pages
with rlmits and go from there.

Wim

On Mon, May 10, 2004 at 06:51:18PM -0700, Wim Coekaerts wrote:
> > >
> > > > Migrating away from this will require work from vendors, Oracle, PAM
> > > > developers, /bin/login and /bin/su developers.  Until that has happened I
> > > > think we should arrange for vendor kernels and kernel.org kernels to offer
> > > > the same interfaces.
> > > 
> > > We have done the work and are going to be ok going forward to just use
> > > hugeltbfs directly, just mounting it with right uid,gid. the main issue
> > 
> > err, so why did I just merge the hugetlb_shm_group patch?
