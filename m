Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbUKBULU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUKBULU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 15:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbUKBULT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 15:11:19 -0500
Received: from unthought.net ([212.97.129.88]:16802 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262020AbUKBUJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 15:09:26 -0500
Date: Tue, 2 Nov 2004 21:09:25 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
Message-ID: <20041102200925.GA12752@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
References: <41877751.502@wasp.net.au> <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4187E4E1.5080304@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 02:49:53PM -0500, Jeff Garzik wrote:
> Trond Myklebust wrote:
...
> >  http://nfs.sourceforge.net/nfs-howto/server.html#CONFIG
> 
> 
> I'm also seeing stale filehandle problems here in recent kernels.
> 
> Setup:  x86 or x86-64, TCP, NFSv4 compiled in to both server and client, 
> but not specified in mount options.
> 
> This is readily reproducible with rsync -- I just boot to an earlier 
> version of the kernel on the NFS client, and the stale filehandle 
> problems go away.

Hi Jeff,

Does running an 'ls' on the server in the exported directory that is
stale on the client resolve the problem (temporarily)?

(working with really weird stale handle theories here I admit...)

-- 

 / jakob

