Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWDTRT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWDTRT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWDTRT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:19:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39814 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751184AbWDTRT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:19:26 -0400
Date: Thu, 20 Apr 2006 18:19:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com, sct@redhat.com,
       aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] FS-Cache: Export find_get_pages()
Message-ID: <20060420171922.GB21659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, steved@redhat.com, sct@redhat.com, aviro@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
	nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
References: <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> <20060420165935.9968.11060.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420165935.9968.11060.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 05:59:35PM +0100, David Howells wrote:
> The attached patch exports find_get_pages() for use by the kAFS filesystem in
> conjunction with it caching patch.

Why don't you use pagevec ?

