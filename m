Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751825AbWICBEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWICBEK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 21:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWICBEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 21:04:10 -0400
Received: from cs.columbia.edu ([128.59.16.20]:51612 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S1751822AbWICBEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 21:04:08 -0400
Subject: Re: [PATCH 04/22][RFC] Unionfs: Common file operations
From: Shaya Potter <spotter@cs.columbia.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Josef Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
In-Reply-To: <1157151440.5628.42.camel@localhost>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060901014138.GE5788@fsl.cs.sunysb.edu>
	 <1157149200.5628.38.camel@localhost>
	 <1157150161.4398.4.camel@localhost.localdomain>
	 <1157151440.5628.42.camel@localhost>
Content-Type: text/plain
Date: Sat, 02 Sep 2006 21:03:22 -0400
Message-Id: <1157245402.4398.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter2.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 18:57 -0400, Trond Myklebust wrote:
> On Fri, 2006-09-01 at 18:36 -0400, Shaya Potter wrote:
> > On Fri, 2006-09-01 at 18:20 -0400, Trond Myklebust wrote:
> > 
> > > Race! You cannot open an underlying NFS file by name after it has been
> > > looked up: you have no guarantee that it hasn't been renamed.
> > 
> > In a unionfs case that's not an issue.  Nothing else is allowed to use
> > the backing store (i.e. the nfs fs) while unionfs is using it, so there
> > shouldn't be a renaming issue.
> 
> How are you enforcing that on the server?

If I formatted a partition on a san w/ ext3, who would enforce that only
one machine has access to it at a time?

the administrator of the file system.


-- 
VGER BF report: H 0
