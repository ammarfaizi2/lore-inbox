Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTFYO53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 10:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTFYO53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 10:57:29 -0400
Received: from [198.149.18.6] ([198.149.18.6]:51428 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264498AbTFYO52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 10:57:28 -0400
Subject: Re: [2.5.73-mm1 XFS] restrict_chown and quotas
From: Steve Lord <lord@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, grendel@debian.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030625153545.A16074@infradead.org>
References: <20030625095126.GD1745@thanes.org>
	<1056545505.1170.19.camel@laptop.americas.sgi.com>
	<20030625134129.GG1745@thanes.org>
	<1056551143.5779.0.camel@laptop.fenrus.com> 
	<20030625153545.A16074@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Jun 2003 10:11:40 -0500
Message-Id: <1056553902.1416.61.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 09:35, Christoph Hellwig wrote:
> On Wed, Jun 25, 2003 at 04:25:44PM +0200, Arjan van de Ven wrote:
> > another question is why is this a filesystem specific option and not a
> > generic option ?
> 
> Heh, I wonder the same when this was implemented the first time.
> 
> It should probably move to VFS.

This is all backwards compatibility with folks expecting Irix behavior,
and I think on Irix it is even a backwards compatibility thing. If we
were not having a major power outage at work right now I could look
at Irix and confirm this. Imposing different semantics on the rest of
the filesystems did not seem like the right thing to do.

Steve


