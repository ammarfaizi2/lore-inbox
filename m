Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUHWUbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUHWUbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267764AbUHWU2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:28:21 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:38664 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267774AbUHWU0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:26:31 -0400
Date: Mon, 23 Aug 2004 21:26:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][7/7] add xattr support to ramfs
Message-ID: <20040823212623.A20995@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org
References: <Xine.LNX.4.44.0408231420100.13728-100000@thoron.boston.redhat.com> <Xine.LNX.4.44.0408231421200.13728-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Xine.LNX.4.44.0408231421200.13728-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Mon, Aug 23, 2004 at 02:22:20PM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 02:22:20PM -0400, James Morris wrote:
> This patch adds xattr support to tmpfs, and a security xattr handler.
> Original patch from: Chris PeBenito <pebenito@gentoo.org>

What's the point on doing this for ramfs?  And if you really want this
the implementation could be shared with tmpfs easily and put into xattr.c

