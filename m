Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267833AbUHWUxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267833AbUHWUxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267835AbUHWUxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:53:47 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:40200 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267798AbUHWUqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:46:35 -0400
Date: Mon, 23 Aug 2004 21:46:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][7/7] add xattr support to ramfs
Message-ID: <20040823214627.A21313@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	lkml <linux-kernel@vger.kernel.org>
References: <Xine.LNX.4.44.0408231420100.13728-100000@thoron.boston.redhat.com> <Xine.LNX.4.44.0408231421200.13728-100000@thoron.boston.redhat.com> <20040823212623.A20995@infradead.org> <1093292789.27211.279.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1093292789.27211.279.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Mon, Aug 23, 2004 at 04:26:29PM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 04:26:29PM -0400, Stephen Smalley wrote:
> > What's the point on doing this for ramfs?  And if you really want this
> > the implementation could be shared with tmpfs easily and put into xattr.c
> 
> For udev.

Last time I checked udev required neither ramfs nor xattrs.

