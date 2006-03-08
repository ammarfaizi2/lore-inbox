Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWCHVbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWCHVbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWCHVbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:31:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38868 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932472AbWCHVbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:31:14 -0500
Date: Wed, 8 Mar 2006 21:31:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] NFS: Add dentry materialisation op [try #7]
Message-ID: <20060308213107.GC8042@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, akpm@osdl.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com> <20060308203026.25493.17935.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308203026.25493.17935.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  (*) _d_rehash() has been added as a wrapper around __d_rehash() to call it
>      with the most obvious hash list (the one from the name). d_rehash() now
>      calls _d_rehash().

We're not really kean on single _ prefix functions.  Could you give it a saner
name instead (or a new one for __d_rehash and rename _d_reshash to that)

