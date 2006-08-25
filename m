Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWHYOMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWHYOMs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWHYOMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:12:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11722 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751211AbWHYOMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:12:47 -0400
Date: Fri, 25 Aug 2006 15:12:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/17] BLOCK: Separate the bounce buffering code from the highmem code [try #2]
Message-ID: <20060825141226.GE10659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213300.21323.67601.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824213300.21323.67601.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- /dev/null
> +++ b/mm/bounce.c
> @@ -0,0 +1,302 @@
> +/* bounce.c: bounce buffer handling for block devices
> + *
> + * - Split from highmem.c
> + */

please don't mention the filename in the top of file comment, it's redundant
and get out of sync too easily on renames.  Otherwise the patch looks good.

