Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbVI3QpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbVI3QpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbVI3QpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:45:11 -0400
Received: from mx.pathscale.com ([64.160.42.68]:32988 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030366AbVI3QpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:45:10 -0400
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       vandrove@vc.cvut.cz, alokk@calsoftinc.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org, ananth@in.ibm.com,
       ak@suse.de
In-Reply-To: <Pine.LNX.4.62.0509300853520.29202@schroedinger.engr.sgi.com>
References: <20050919112912.18daf2eb.akpm@osdl.org>
	 <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com>
	 <20050919122847.4322df95.akpm@osdl.org>
	 <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com>
	 <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz>
	 <20050928210245.GA3760@localhost.localdomain> <433C1999.2060201@vc.cvut.cz>
	 <20050930054556.GA3599@localhost.localdomain>
	 <20050929230540.6a8651fa.akpm@osdl.org>
	 <20050930062853.GB3599@localhost.localdomain>
	 <1128093382.10913.92.camel@serpentine.pathscale.com>
	 <Pine.LNX.4.62.0509300853520.29202@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 09:45:04 -0700
Message-Id: <1128098704.10913.100.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 08:57 -0700, Christoph Lameter wrote:
> On Fri, 30 Sep 2005, Bryan O'Sullivan wrote:
> 
> > Kiran, your patch works for me, too.  I can boot 2.6.14-rc2 with your
> > patch, but not without it.
> 
> The patch is not in rc2-mm2 right?

Correct.

>  I can now reproduce it on a AMD64 
> single processor with numa emulation (numa=fake=2).

That's helpful for reproducing the problem.  Thanks.

>  So all x86_64 NUMA 
> systems will throw these same stacktraces for rc2-mm2?

I've only tried with HDAMA motherboards, but based on your report and
Petr's, it seems somewhat likely.

	<b

