Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUD3Qpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUD3Qpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUD3Qpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:45:51 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:10247 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265099AbUD3Qpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:45:49 -0400
Date: Fri, 30 Apr 2004 17:45:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rik van Riel <riel@redhat.com>
Cc: Erik Jacobson <erikj@subway.americas.sgi.com>, Paul Jackson <pj@sgi.com>,
       chrisw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Message-ID: <20040430174543.A13431@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rik van Riel <riel@redhat.com>,
	Erik Jacobson <erikj@subway.americas.sgi.com>,
	Paul Jackson <pj@sgi.com>, chrisw@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040430140611.A11636@infradead.org> <Pine.LNX.4.44.0404301122200.6976-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0404301122200.6976-100000@chimarrao.boston.redhat.com>; from riel@redhat.com on Fri, Apr 30, 2004 at 11:22:49AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 11:22:49AM -0400, Rik van Riel wrote:
> > Again, pagg doesn't even play in that league.  It's really just a tiny
> > meachnism to allow a kernel module keep per-process data.  Policies like
> > process-groups can be implemented on top of that.
> 
> So basically you're arguing that PAGG is better because it
> doesn't do what's needed ? ;)

I told you a bunch of times that's it's a different thing.  Simply keeping
per-process state might be a useful building block for some monster resource
whatever fuckup, but certainly not the other way around.

