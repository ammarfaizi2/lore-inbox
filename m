Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbULPUPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbULPUPg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbULPUPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:15:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19914 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261986AbULPUPb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:15:31 -0500
Date: Thu, 16 Dec 2004 15:23:23 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Adam Heath <doogie@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.29-pre2
Message-ID: <20041216172323.GH9986@logos.cnet>
References: <20041216113559.GF8246@logos.cnet> <Pine.LNX.4.58.0412161349260.2173@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412161349260.2173@gradall.private.brainfood.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 01:50:40PM -0600, Adam Heath wrote:
> On Thu, 16 Dec 2004, Marcelo Tosatti wrote:
> 
> > Hi,
> >
> > Here goes the second -pre of Linux v2.4.29.
> 
> I don't know if you've been following, but it was recently discoverd that on
> smp, if multiple processes read from /dev/urandom at the same time, they can
> get the same data.  Theodore Tytso posted a patch to fix this for 2.6, and
> someone else told me this problem has existed all the way back to 1.3.
> 
> This is a security issue, and should be included in the 2.4 tree.

Yes, I'm aware of it, Tytso is working on v2.4 backport of the correct locking.

Thanks for the reminder!

