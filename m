Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbUKRCTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbUKRCTt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbUKRCAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 21:00:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1996 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262379AbUKQUT1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:19:27 -0500
Date: Wed, 17 Nov 2004 20:19:26 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Robert Love <rml@novell.com>
Cc: Christoph Hellwig <hch@infradead.org>, ttb@tentacle.dhs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify: vfs_permission was replaced
Message-ID: <20041117201925.GG26051@parcelfarce.linux.theplanet.co.uk>
References: <1100710677.6280.2.camel@betsy.boston.ximian.com> <1100714560.6280.7.camel@betsy.boston.ximian.com> <20041117190850.GA11682@infradead.org> <1100718601.4981.2.camel@betsy.boston.ximian.com> <20041117191803.GA11830@infradead.org> <1100719052.4981.4.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100719052.4981.4.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 02:17:32PM -0500, Robert Love wrote:
> On Wed, 2004-11-17 at 19:18 +0000, Christoph Hellwig wrote:
> 
> > No it doesn't.  Please try to understand the APIs before you're using them.
> > Just looking at the callers should give you an immediate clue.
> 
> Maybe you should look at the code in question.  We actually want to
> perform the exact same sort of permission checks that, say, read
> performs.

Maybe you should look at the code in kernel - e.g. aforementioned sys_read().
Or sys_open().

The only fs-independent code that has any business calling that puppy is
permission(9).
