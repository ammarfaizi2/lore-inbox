Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbTI3Mkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbTI3Mkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:40:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44266 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261439AbTI3Mkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:40:41 -0400
Date: Tue, 30 Sep 2003 14:40:38 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ast@domdv.de, schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20030930124038.GR2908@suse.de>
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de> <20030930115411.GL2908@suse.de> <3F797316.2010401@domdv.de> <20030930122137.GN2908@suse.de> <20030930053224.030101c5.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930053224.030101c5.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30 2003, David S. Miller wrote:
> On Tue, 30 Sep 2003 14:21:37 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > I will tell you to talk to the glibc folks, because that's where your
> > problem is.
> 
> I think it's totally unreasonable to expect the glibc folks
> to suck in every single new weird API that ends up in the kernel.
> 
> Part of this is our job.

We agree 100% here, have you read any of my emails in this thread?! I'm
not trying to place blame, it's a joint effort for sure.

> But until we have that bit solved, it's irresonsible of us to tell
> users to go scream at the glibc people.  Rather, we should fix the
> (really, honestly, incredibly minor) things that prevent these kernel
> header files from working for users.

Talk to glibc folks: point out the inconsistency. Maybe he'll be a good
boy and provide a patch, who knows. That's doesn't imply screaming.

And yes, I'm not on a mission to make sure that kernel headers
absolutely don't work from user space. And I'm even sure that had Joerg
provided a patch in his original email, it might even have been included
in the kernel. The attitude surely doesn't help either.

-- 
Jens Axboe

