Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWFXSTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWFXSTB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 14:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWFXSTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 14:19:01 -0400
Received: from narn.hozed.org ([209.234.73.39]:55516 "EHLO narn.hozed.org")
	by vger.kernel.org with ESMTP id S1751024AbWFXSTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 14:19:01 -0400
Date: Sat, 24 Jun 2006 13:19:00 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Change in-kernel afs client filesystem name to 'kafs'
Message-ID: <20060624181900.GP5040@narn.hozed.org>
References: <20060624004154.GL5040@narn.hozed.org> <20060624133703.GB15734@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060624133703.GB15734@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 02:37:03PM +0100, Christoph Hellwig wrote:
> On Fri, Jun 23, 2006 at 07:41:59PM -0500, Troy Benjegerdes wrote:
> > This patch changes the in-kernel AFS client filesystem name to 'kafs',
> > as well as allowing the AFS cache manager port to be set as a module
> > parameter. This is usefull for having a system boot with the root
> > filesystem on afs with the kernel AFS client, while still having the
> > option of loading the OpenAFS kernel module for use as a read-write
> > filesystem later.
> 
> NACK.  OpenAFS isn't even legal to load into the kernel, we shouldn't
> support it.  Better help making the kernel afs client fully features
> than wasting your time on this.

So, you are telling me that even though OpenAFS has a license
substationally similiar in intent to the GPLv2, that it's not legal to
load into the kernel, even though the OpenAFS code predates the Linux
kernel by about 5 years? Are you going to personally sue me if I put up
an initramfs image with the OpenAFS kernel module in it?

This is not a binary-only linux-only module we are talking about here.
This is a cross-platform code that loads into multiple different
operating system kernels and has the same sort of protection of user's
right to modify the code that Linux does. It only differs in some of the
details.

My home directory is in AFS. And if you want me to help make the kernel
AFS client full-featured, I need to have both kAFS and OpenAFS loaded
and mounted at the same time. So quit bitching about OpenAFS and get out of
my way so I can work on kAFS.
