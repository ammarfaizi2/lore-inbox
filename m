Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWIAW5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWIAW5d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWIAW5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:57:33 -0400
Received: from pat.uio.no ([129.240.10.4]:4336 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751106AbWIAW5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:57:31 -0400
Subject: Re: [PATCH 04/22][RFC] Unionfs: Common file operations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: Josef Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
In-Reply-To: <1157150161.4398.4.camel@localhost.localdomain>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060901014138.GE5788@fsl.cs.sunysb.edu>
	 <1157149200.5628.38.camel@localhost>
	 <1157150161.4398.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 18:57:20 -0400
Message-Id: <1157151440.5628.42.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.209, required 12,
	autolearn=disabled, AWL 1.79, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 18:36 -0400, Shaya Potter wrote:
> On Fri, 2006-09-01 at 18:20 -0400, Trond Myklebust wrote:
> 
> > Race! You cannot open an underlying NFS file by name after it has been
> > looked up: you have no guarantee that it hasn't been renamed.
> 
> In a unionfs case that's not an issue.  Nothing else is allowed to use
> the backing store (i.e. the nfs fs) while unionfs is using it, so there
> shouldn't be a renaming issue.

How are you enforcing that on the server?



-- 
VGER BF report: H 2.77556e-16
