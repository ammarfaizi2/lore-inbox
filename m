Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVACLtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVACLtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 06:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVACLtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 06:49:17 -0500
Received: from [213.146.154.40] ([213.146.154.40]:18150 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261329AbVACLtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 06:49:13 -0500
Date: Mon, 3 Jan 2005 11:48:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-ID: <20050103114854.GA18408@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-kernel@vger.kernel.org
References: <20050103011113.6f6c8f44.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103011113.6f6c8f44.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  reiser4-export-inode_lock.patch

Han,s how'as the work progressing on removing these and other fishy
core changes?

>  reiser4-unstatic-kswapd.patch

Andrew, could you please finally drop this one?  It's not needed for
reiser4 operation at all just for some of their stranger debugging
features.

>  
>  reiser4-include-reiser4.patch

What about moving fs/Kconfig.reiser4 to fs/reiser4/Kconfig?  This is
the logical place for it and makes dropping in a new version of the fs
easier.

>  reiser4-only.patch

Documentation shouldn't be in fs/FOO/doc but Documentation/filesystems/.

