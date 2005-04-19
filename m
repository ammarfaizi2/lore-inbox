Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVDSHba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVDSHba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 03:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVDSHba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 03:31:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51433 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261370AbVDSHb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 03:31:28 -0400
Date: Tue, 19 Apr 2005 00:28:08 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-Id: <20050419002808.66c9f66b.pj@sgi.com>
In-Reply-To: <1113894584.5074.54.camel@npiggin-nld.site>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<1113891575.5074.46.camel@npiggin-nld.site>
	<20050418235902.7632d68a.pj@sgi.com>
	<1113894584.5074.54.camel@npiggin-nld.site>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> That would make sense. I'm not familiar with the workings of cpusets,
> but that would require every task to be assigned to one of these
> sets (or a subset within it), yes?

That's the rub, as I noted a couple of messages ago, while you
were writing this message.

It doesn't require every task to be in one of these or a subset.

Tasks could be in some multiple-domain superset, unless that is so
painful that we have to add mechanisms to cpusets to prohibit it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
