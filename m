Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266830AbUHCWwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266830AbUHCWwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUHCWwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:52:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:63668 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266830AbUHCWwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:52:05 -0400
Date: Tue, 3 Aug 2004 15:52:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803155202.S1924@build.pdx.osdl.net>
References: <Pine.LNX.4.44.0408031654290.5948-100000@dhcp83-102.boston.redhat.com> <20040803210737.GI2241@dualathlon.random> <20040803211339.GB26620@devserv.devel.redhat.com> <20040803213634.GK2241@dualathlon.random> <20040803213856.GB10978@devserv.devel.redhat.com> <20040803215150.GM2241@dualathlon.random> <20040803150118.Q1924@build.pdx.osdl.net> <20040803221121.GN2241@dualathlon.random> <20040803153335.R1924@build.pdx.osdl.net> <20040803224200.GO2241@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040803224200.GO2241@dualathlon.random>; from andrea@suse.de on Wed, Aug 04, 2004 at 12:42:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> On Tue, Aug 03, 2004 at 03:33:35PM -0700, Chris Wright wrote:
> > Heh, yeah in a place like hugetlb_put_quota?
> 
> yep. that's the kind of function I was looking for to update/release the
> accounting, but it's not there, and sure it wasn't there in the previous
> patch either.

I didn't see it there either.  But I think it's fixable.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
