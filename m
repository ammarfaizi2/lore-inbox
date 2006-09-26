Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWIZEKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWIZEKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 00:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWIZEKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 00:10:36 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:17583 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750845AbWIZEKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 00:10:35 -0400
X-Sasl-enc: vIq8HT1+9KeAdC+6/ZyJdZ4JP2qbHyhE3FoixDyFzp5M 1159243836
Date: Tue, 26 Sep 2006 12:10:26 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Autofs4 breakage (was 2.6.19 -mm merge plans)
In-Reply-To: <1158789333.5639.37.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0609261206380.2953@raven.themaw.net>
References: <20060920135438.d7dd362b.akpm@osdl.org> <1158789333.5639.37.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Trond Myklebust wrote:

> On Wed, 2006-09-20 at 13:54 -0700, Andrew Morton wrote:
> 
> > add-newline-to-nfs-dprintk.patch
> > fs-nfs-make-code-static.patch
> > 
> >  NFS queue -> Trond.
> > 
> >  The NFS git tree breaks autofs4 submounts.  Still.
> 
> I still suspect that is due to a misconfigured selinux setup on your
> machine. If autofs4 expects to be able to do mkdir() on your NFS
> partition (something which in itself is wrong), then selinux should be
> configured to allow it to do so.

As we decided I am working on changing this and it's well on the way to 
being completed. It's actually somewhat more complex than just not 
creating directories on non-autofs file systems.

Once again, sorry for the delay.

Ian

