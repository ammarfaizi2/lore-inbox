Return-Path: <linux-kernel-owner+w=401wt.eu-S964777AbXAHVkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbXAHVkX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbXAHVkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:40:22 -0500
Received: from cs.columbia.edu ([128.59.16.20]:39759 "EHLO cs.columbia.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932152AbXAHVkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:40:19 -0500
Subject: Re: [PATCH 01/24] Unionfs: Documentation
From: Shaya Potter <spotter@cs.columbia.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
In-Reply-To: <20070108131957.cbaf6736.akpm@osdl.org>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	 <1168229596875-git-send-email-jsipek@cs.sunysb.edu>
	 <20070108111852.ee156a90.akpm@osdl.org>
	 <Pine.LNX.4.63.0701081442230.19059@razor.cs.columbia.edu>
	 <20070108131957.cbaf6736.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 16:30:48 -0500
Message-Id: <1168291848.9853.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.4 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter1.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-08 at 13:19 -0800, Andrew Morton wrote:
> On Mon, 8 Jan 2007 14:43:39 -0500 (EST) Shaya Potter <spotter@cs.columbia.edu> wrote:
> >  It's the same thing as modifying a block 
> > device while a file system is using it.  Now, when unionfs gets confused, 
> > it shouldn't oops, but would one expect ext3 to allow one to modify its 
> > backing store while its using it?
> 
> There's no such problem with bind mounts.  It's surprising to see such a
> restriction with union mounts.

the difference is bind mounts are a vfs construct, while unionfs is a
file system.

