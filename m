Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTEMQ0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTEMQ0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:26:48 -0400
Received: from havoc.daloft.com ([64.213.145.173]:32212 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261722AbTEMQ0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:26:44 -0400
Date: Tue, 13 May 2003 12:39:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support
Message-ID: <20030513163929.GB30944@gtf.org>
References: <8624.1052840360@warthog.warthog> <20030513170317.A29503@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513170317.A29503@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:03:17PM +0100, Christoph Hellwig wrote:
> On Tue, May 13, 2003 at 04:39:20PM +0100, David Howells wrote:
> >  (3) AFS multiplexor support. Not complete at the moment, but implemented far
> >      enough to provide access to the PAG mechanism. Further patches will be
> >      forthcoming to make this fully functional.
> 
> This is broken.  Please add individual syscalls instead of yet another broken
> multiplexer.

AFS is annoying and painful no matter how you look at it.  :/

But I don't think 90+ new syscalls is the answer, even for 2.7.

File this under "design mistake we must live with", much like
ioctl(2) itself.

	Jeff



