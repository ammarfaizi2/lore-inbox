Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269216AbUINJLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269216AbUINJLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUINJLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:11:53 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:54282 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269216AbUINJLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:11:52 -0400
Date: Tue, 14 Sep 2004 10:11:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm5: Oops related to reiserfs, other stuff
Message-ID: <20040914101149.A5454@infradead.org>
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


Andrew, can you please backoput the fs/reiserfs/ parts of
generic-acl-support-for-permission.patch ?  Due their messy way of using
inodes for storing xattrs the current code can't work.  I have an idea on
how to fix that, but it'll take some time.


