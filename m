Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVA3K6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVA3K6K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 05:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVA3K6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 05:58:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26005 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261672AbVA3K5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 05:57:41 -0500
Date: Sun, 30 Jan 2005 10:57:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Paul Blazejowski <diffie@gmail.com>, linux-kernel@vger.kernel.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.11-rc2-mm2
Message-ID: <20050130105738.GA28387@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Paul Blazejowski <diffie@gmail.com>,
	linux-kernel@vger.kernel.org, Nathan Scott <nathans@sgi.com>
References: <9dda349205012923347bc6a456@mail.gmail.com> <20050129235653.1d9ba5a9.akpm@osdl.org> <20050130105429.GA28300@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130105429.GA28300@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 10:54:29AM +0000, Christoph Hellwig wrote:
> We want to avoid building xfs_export.o when CONFIG_EXPORTFS
> isn't set.  CONFIG_XFS_EXPORT=y and CONFIG_EXPORTFS=m worked for
> me in my testing.  Do you have XFS builtin or modular?
> 
> I suspect we need to add another weird depency to force XFS builtin
> when NFSD is modular.

s/modular/builtin/ in the last sentence
