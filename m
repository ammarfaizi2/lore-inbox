Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265008AbTFQXlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 19:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265010AbTFQXlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 19:41:16 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:41672 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S265008AbTFQXlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 19:41:15 -0400
Date: Tue, 17 Jun 2003 16:55:07 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() again, and trivial nfs_fhget
Message-ID: <20030617165507.A19126@google.com>
References: <20030617051408.A17974@google.com> <shs1xxsr1gx.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <shs1xxsr1gx.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Jun 17, 2003 at 11:41:18AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 11:41:18AM -0700, Trond Myklebust wrote:
> >>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:
> 
>      > The first one didn't make it into 2.5.71/72, but is
>      > necessary. :-)
> 
> Why are you doing this in the VFS?

Simple place to fix it.

> There is already code to handle this case in the NFS filesystem code
> itself.

No, there isn't.

> If you think that code is wrong then make an argument for
> changing it, and send me a patch.

I did make an argument, and did send you a patch.  Please see my email
with message id <20030611002226.A19078@google.com>.

/fc
