Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbUKQF5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbUKQF5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 00:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbUKQF5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 00:57:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54658 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262177AbUKQF5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 00:57:41 -0500
Date: Wed, 17 Nov 2004 15:55:06 +1100
From: Nathan Scott <nathans@sgi.com>
To: Brad Fitzpatrick <brad@danga.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lisa@danga.com, marksmith@danga.com,
       linux-xfs@oss.sgi.com
Subject: Re: 2.6.9: unkillable processes during heavy IO
Message-ID: <20041117045506.GA1802@frodo>
References: <Pine.LNX.4.58.0411141403040.22805@danga.com> <Pine.LNX.4.58.0411160549070.7904@danga.com> <20041116200156.2b2526e5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116200156.2b2526e5.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 08:01:56PM -0800, Andrew Morton wrote:
> Brad Fitzpatrick <brad@danga.com> wrote:
> >
> > Here is the information requested regarding the regular lockup we're
> > seeing (details in original post at bottom)
> 
> yup, that looks like a locking tangle in the XFS direct-io code.
> 
> Nathan, this is 2.6.9.

Hmmm, yeah, looks like it - bother.  

> > On Sun, 14 Nov 2004, Brad Fitzpatrick wrote:
> > 
> > > We have two database servers which freeze up during heavy IO load.  The

Brad, could you send me details on how you've setup mysqld
and how to generate a load similar to yours, so that I can
reproduce the hang locally?

> > > The hardware/software stack is:
> > >
> > >   - Dual Opteron 246, SMP kernel, w/ NUMA
> > >   - 9 GB of memory (4GB in one zone, 5GB in the other)
> > >   - MySQL, running mostly InnoDB, but some MyISAM

( I don't even know what those two things are, so you can
probably guess at the level of assistance I'll need here. :)

thanks!

-- 
Nathan
