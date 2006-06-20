Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWFTIzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWFTIzt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbWFTIzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:55:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50591 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965068AbWFTIzr (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:55:47 -0400
Subject: Re: batched write
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, Linux-Kernel@vger.kernel.org,
       Reiserfs-Dev@namesys.com, hch@infradead.org, vs@namesys.com,
       dgc@sgi.com, Hans Reiser <reiser@namesys.com>
In-Reply-To: <20060620002659.08aee963.akpm@osdl.org>
References: <20060524175312.GA3579@zero> 	<44749E24.40203@namesys.com>
	 <20060608110044.GA5207@suse.de>
	 <1149766000.6336.29.camel@tribesman.namesys.com>
	 <20060608121006.GA8474@infradead.org>
	 <1150322912.6322.129.camel@tribesman.namesys.com>
	 <20060617100458.0be18073.akpm@osdl.org>
	 <20060619162740.GA5817@schatzie.adilger.int> <4496D606.8070402@namesys.com>
	 <20060619185049.GH5817@schatzie.adilger.int>
	 <20060620000133.GB8770394@melbourne.sgi.com> 	<4497A17C.50804@namesys.com>
	 <20060620002659.08aee963.akpm@osdl.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 20 Jun 2006 10:02:53 +0100
Message-Id: <1150794173.3856.1305.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-06-20 at 00:26 -0700, Andrew Morton wrote:
> On Tue, 20 Jun 2006 00:19:24 -0700
> Hans Reiser <reiser@namesys.com> wrote:
> 
> > So far we have XFS, FUSE, and reiser4 benefiting from the potential
> > ability to process more than 4k at a time.  Is it enough?
> 
> Spose so.  Let's see what the diff looks like?
> -

I have plans to do something along these lines for GFS2 in the future,
so you can add that to the list as well, if that helps things along,

Steve.


