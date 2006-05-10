Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWEJQXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWEJQXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWEJQXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:23:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24023 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965005AbWEJQXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:23:52 -0400
Date: Wed, 10 May 2006 17:23:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/14] NFS: Share NFS superblocks per-protocol per-server per-FSID [try #8]
Message-ID: <20060510162342.GA18827@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
	aviro@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
	linux-kernel@vger.kernel.org
References: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com> <20060510160132.9058.35796.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510160132.9058.35796.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As last time a big fat "no fucking way" for the exports.  I already told
you how to fix it by creating a common helper in the VFS last time.

