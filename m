Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbULKPZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbULKPZL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 10:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbULKPZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 10:25:11 -0500
Received: from [213.146.154.40] ([213.146.154.40]:29387 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261946AbULKPYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 10:24:04 -0500
Date: Sat, 11 Dec 2004 15:24:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Export of generic_forget_inode()
Message-ID: <20041211152403.GB11522@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
References: <41BAF7C1.4080800@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BAF7C1.4080800@sw.ru>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2004 at 04:36:01PM +0300, Kirill Korotaev wrote:
> This patch adds export of generic_forget_inode()
> 
> if sb->drop_inode method is set, than it's called in iput_final().
> But it's impossible to call neither generic_drop_inode(), nor 
> generic_forget_inode() inside this handler. Only generic_delete_inode() 
> is accessiable.

I don't see that this patch introduces any user for it.

