Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVHRLA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVHRLA4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 07:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVHRLAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 07:00:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53205 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932186AbVHRLAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 07:00:55 -0400
Date: Thu, 18 Aug 2005 12:00:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/7] rename locking functions - do the rename
Message-ID: <20050818110051.GA6606@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200508180207.14574.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508180207.14574.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 02:07:14AM +0200, Jesper Juhl wrote:
> This patch renames sema_init to init_sema, init_MUTEX to init_mutex and
> init_MUTEX_LOCKED to init_mutex_locked  and at the same time creates 3 
> (deprecated) wrapper functions with the old names.

What's the point?  There's not need for totally gratious renaming.

