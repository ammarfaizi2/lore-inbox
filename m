Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUEKTri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUEKTri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbUEKTri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:47:38 -0400
Received: from radius8.csd.net ([204.151.43.208]:2202 "EHLO
	bastille.tuells.org") by vger.kernel.org with ESMTP id S263540AbUEKTrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:47:37 -0400
Date: Tue, 11 May 2004 13:48:53 -0600
From: marcus hall <marcus@tuells.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Block device swamping disk cache
Message-ID: <20040511194853.GA16216@bastille.tuells.org>
References: <20040511191124.GA16014@bastille.tuells.org> <20040511201936.A19384@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511201936.A19384@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 08:19:36PM +0100, Christoph Hellwig wrote:
> > I am running an arm version of the 2.5.59 kernel.
> 
> I don't think anyone here still remembers stoneage-aera kernels.
> 
> You're better off trying to reproduce it with 2.6.6 I guess.

Well, when we started the project, the 2.5.59 base was the most current.
Since then, there hasn't been time to try to update all of the drivers to
the 2.6 kernel.  I would like to eventually get there, but at this point
it's an unfunded mandate.

So, my question is just in general terms, what is supposed to occur to flush
blocks out to a block device?  Is the inode supposed to be marked as dirty
and queued on the superblock containing the block device file (sort of what
I expected to be seeing), or is there some other method?  I can transpose
between the 2.6 and 2.5 kernels enough to try to see what isn't happening,
unless the strategy has changed in the 2.6 kernel..

Marcus Hall
marcus@tuells.org
