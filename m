Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269042AbUHMJnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269042AbUHMJnb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 05:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269046AbUHMJnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 05:43:31 -0400
Received: from gate.in-addr.de ([212.8.193.158]:62894 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S269042AbUHMJnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 05:43:24 -0400
Date: Fri, 13 Aug 2004 11:40:24 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Steven Dake <sdake@mvista.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>,
       dcl_discussion@osdl.org, "Walker, Bruce J" <bruce.walker@hp.com>,
       linux-kernel@vger.kernel.org, cgl_discussion@osdl.org
Subject: Re: [Linux-cluster] Re: [cgl_discussion] Re: [dcl_discussion] Clustersummit materials
Message-ID: <20040813094024.GH4161@marowsky-bree.de>
References: <3689AF909D816446BA505D21F1461AE4C75110@cacexc04.americas.cpqcorp.net> <1092249962.4717.21.camel@persist.az.mvista.com> <20040812095736.GE4096@marowsky-bree.de> <1092332536.7315.1.camel@persist.az.mvista.com> <20040812203738.GK9722@marowsky-bree.de> <1092351549.7315.5.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1092351549.7315.5.camel@persist.az.mvista.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-08-12T15:59:10,
   Steven Dake <sdake@mvista.com> said:

> Thanks for posting transis.  I had a look at the examples and API.  The
> API is of course different then openais and focused on client/server
> architecture.

Right.

> I tried a performance test by sending a 64k message, and then receiving
> it 10 times with two nodes.  This operation takes about 5 seconds on my
> hardware which is 128k/sec.  I was expecting more like 8-10MB/sec.  Is
> there anything that can be done to improve the performance?

I've not yet done any real tests with it, so I'm not sure. We were
mostly going from the theoretical description ;) But I think 128k/s is
really a bit low, so I assume something ain't quite right yet... We'll
figure it out.

It's possible that maybe it's not the way to go afterall, but before we
could go looking we first needed it as GPL/LGPL (for not becoming
IP-tainted).


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \        This space          /
SUSE Labs, Research and Development |       intentionally        |
SUSE LINUX AG - A Novell company    \        left blank          /
