Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWEND4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWEND4j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 23:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWEND4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 23:56:38 -0400
Received: from ns2.suse.de ([195.135.220.15]:11497 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964785AbWEND4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 23:56:37 -0400
Date: Sat, 13 May 2006 20:54:22 -0700
From: Greg KH <greg@kroah.com>
To: Michael Halcrow <lkml@halcrow.us>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       michael.craig.thompson@gmail.com, phillip@hellewell.homeip.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       toml@us.ibm.com, yoder1@us.ibm.com, jmorris@namei.org, sct@redhat.com,
       ezk@cs.sunysb.edu, dhowells@redhat.com
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
Message-ID: <20060514035422.GA6451@kroah.com>
References: <20060513033742.GA18598@hellewell.homeip.net> <44655ECD.10404@yahoo.com.au> <afcef88a0605130921k7139da13k1b7232acb29140c1@mail.gmail.com> <44669D12.5050306@yahoo.com.au> <20060513201341.63590cff.akpm@osdl.org> <4466A37F.4030601@yahoo.com.au> <20060514034346.GA4427@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060514034346.GA4427@halcrow.us>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 10:43:46PM -0500, Michael Halcrow wrote:
> On Sun, May 14, 2006 at 01:26:55PM +1000, Nick Piggin wrote:
> > Compiling at each step is better than not. But my main point is
> > that it is superfluously broken into multiple patches.
> 
> This comment is from about a year ago, so it probably has fallen off
> the radar:
> 
> At 2005-06-02 14:51:54, Greg K-H wrote:
> > On Thu, Jun 02, 2005 at 07:32:19AM -0500, Michael Halcrow wrote:
> > > What sort of
> > > logical chunks would you consider to be appropriate?  Separate patches
> > > for each file (inode.c, file.c, super.c, etc.), which represent sets
> > > of functions for each major VFS object?
> > 
> > Yes.

Yes, but don't break the build along the way.

thanks,

greg k-h
