Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267967AbUIJVym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267967AbUIJVym (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267953AbUIJVym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:54:42 -0400
Received: from waste.org ([209.173.204.2]:30913 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268037AbUIJVyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:54:10 -0400
Date: Fri, 10 Sep 2004 16:53:53 -0500
From: Matt Mackall <mpm@selenic.com>
To: Christoph Hellwig <hch@waste.org>, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] read EXTRAVERSION from file
Message-ID: <20040910215353.GO5414@waste.org>
References: <20040830151405.GA18836@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830151405.GA18836@lst.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 05:14:05PM +0200, Christoph Hellwig wrote:
> The're an very interesting patch in the Debian tree still from the time
> where Herbert Xu mentioned it, it allows creating a file .extraversion
> in the toplevel kernel directory and the Makefile will set EXTRAVERSION
> to it's contents.  This has the nice advantage of keeping an
> extraversion pre-tree instead of having to patch the Makefile and
> getting rejects everytime you pull a new tree (or BK refuses to touch
> the Makefile).
> 
> The only thing I'm not fully comfortable is the .extraversion name, I
> think I'd prefer a user-visible name.
> 
> Any other comments on this one?

(catching up)

Consider this approach as a more flexible alternative:

http://groups.google.com/groups?q=oxymoron+patch+names&hl=en&lr=&ie=UTF-8&selm=fa.jif8l5v.1b049jd%40ifi.uio.no&rnum=1

-- 
Mathematics is the supreme nostalgia of our time.
