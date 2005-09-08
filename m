Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbVIHNtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVIHNtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVIHNtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:49:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45953 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932515AbVIHNtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:49:00 -0400
Date: Thu, 8 Sep 2005 14:48:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
Message-ID: <20050908134857.GA8676@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050908053042.6e05882f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 05:30:42AM -0700, Andrew Morton wrote:
> -ocfs2-prep.patch
> 
>  Dropped this - maintaining the
>  move-truncate_inode_pages-into-delete_inode.patch patch separately was a
>  pita.  Simply pull it in from git-ocfs2.patch

Could you please just send the  move truncate_inode_pages into delete_inode
patch to Linus ASAP instead?  It's useful without OCFS2, I have some changes
that need it pending, and the reiser4 folks also need it to clean some
of their mess up (if they're still interested..)

