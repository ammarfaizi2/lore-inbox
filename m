Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161401AbWKHSHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161401AbWKHSHK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161439AbWKHSHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:07:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12964 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161401AbWKHSHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:07:07 -0500
Date: Wed, 8 Nov 2006 10:04:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Daniel J Blueman <daniel.blueman@gmail.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, nfsv4@linux-nfs.org,
       Neil Brown <neilb@suse.de>, "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Fwd: [PATCH 2/2] nfsd4: fix open-create permissions
Message-Id: <20061108100436.f56986dc.akpm@osdl.org>
In-Reply-To: <4551DCBE.1060508@garzik.org>
References: <6278d2220611060403j2b63cb9cl1d0707e7cf3d7899@mail.gmail.com>
	<20061106161747.GA12372@fieldses.org>
	<20061106162458.GC12372@fieldses.org>
	<6278d2220611060848n3585ebc5odbf39efd6a02ab2@mail.gmail.com>
	<4551DCBE.1060508@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 08:33:50 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Daniel J Blueman wrote:
> > Linus, Trond,
> > 
> > What is the chance of this patch making it into the final 2.6.19?
> > 
> > WIthout it, there is a serious NFSv4 open() regression; I've been
> > running it on client and server for ~1 week under load and it resolves
> > the condition w/o side-effects. See the LKML thread "Poor NFSv4 first
> > impressions" for further details.
> 
> strong ACK, provided that someone who knows the NFSv4 server code well 
> (Neil B?) gives it an ACK.
> 

Neil has acked it.  This is in my for-2.6.19 queue, probably later today.
