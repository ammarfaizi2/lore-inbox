Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVD1IJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVD1IJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVD1IJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:09:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6375 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261922AbVD1IJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:09:23 -0400
Date: Thu, 28 Apr 2005 09:09:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: aq <aquynh@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/Kconfig: more consistent configuration of XFS
Message-ID: <20050428080914.GA10799@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	aq <aquynh@gmail.com>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <9cde8bff050428005528ecf692@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cde8bff050428005528ecf692@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 04:55:48PM +0900, aq wrote:
> hello,
> 
> At the moment, the configuration interface of Filesystem is not very consistent:
> 
> - All other filesystem configurations (like Reiserfs, JFS, ext3,...)
> is in fs/Kconfig, but only XFS is in a separate file fs/xfs/Kconfig
> - All other filesystem configuration is processed in the same screen
> (using a kind of drop-down interface), but XFS configuration is done
> in a separate screen.
> 
> Here is the patch to fix the problem: it moves XFS configuration from
> fs/xfs/Kconfig to fs/Kconfig, makes it to do all the configuration in
> the same screen (by removing "menu" directive), and removes the
> unnecessary fs/xfs/Kconfig.

The screen bits is fine, btu please keep fs/xfs/Kconfig.  It make maintaince
a lot a easier for us XFS people.

