Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWHYORO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWHYORO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWHYORN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:17:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43668 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751486AbWHYORL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:17:11 -0400
Date: Fri, 25 Aug 2006 15:16:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/17] BLOCK: Move __invalidate_device() to block_dev.c [try #2]
Message-ID: <20060825141650.GJ10659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213313.21323.44393.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824213313.21323.44393.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 10:33:13PM +0100, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Move __invalidate_device() from fs/inode.c to fs/block_dev.c so that it can
> more easily be disabled when the block layer is disabled.

Ok.

