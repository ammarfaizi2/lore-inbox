Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268873AbUIMUSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268873AbUIMUSs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUIMUSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:18:48 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:38410 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268873AbUIMUSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:18:39 -0400
Date: Mon, 13 Sep 2004 21:18:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm5: Oops related to reiserfs, other stuff
Message-ID: <20040913211836.A31310@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <200409132211.44109.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200409132211.44109.rjw@sisk.pl>; from rjw@sisk.pl on Mon, Sep 13, 2004 at 10:11:44PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 10:11:44PM +0200, Rafael J. Wysocki wrote:
> Andrew,
> 
> There is a problem in 2.6.9-rc1-mm5 related to the reiserfs handling of ACLs.  
> Namely, if a reiserfs partition is mounted with "-o acl", any attempt to 
> create a file on it results in an Oops similar to this one:

Can you back out the generic ACL patch?  I suspect it's is fault although
I don't see how.
