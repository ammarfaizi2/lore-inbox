Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUHWUfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUHWUfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUHWUcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:32:05 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:2480 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S266786AbUHWUag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:30:36 -0400
Subject: Re: [PATCH][7/7] add xattr support to ramfs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christoph Hellwig <hch@infradead.org>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040823212623.A20995@infradead.org>
References: <Xine.LNX.4.44.0408231420100.13728-100000@thoron.boston.redhat.com>
	 <Xine.LNX.4.44.0408231421200.13728-100000@thoron.boston.redhat.com>
	 <20040823212623.A20995@infradead.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1093292789.27211.279.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 16:26:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 16:26, Christoph Hellwig wrote:
> On Mon, Aug 23, 2004 at 02:22:20PM -0400, James Morris wrote:
> > This patch adds xattr support to tmpfs, and a security xattr handler.
> > Original patch from: Chris PeBenito <pebenito@gentoo.org>
> 
> What's the point on doing this for ramfs?  And if you really want this
> the implementation could be shared with tmpfs easily and put into xattr.c

For udev.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

