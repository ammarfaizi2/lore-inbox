Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752172AbWCGLwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbWCGLwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 06:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbWCGLwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 06:52:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14778 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750856AbWCGLwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 06:52:17 -0500
Date: Tue, 7 Mar 2006 11:52:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] NFS: Abstract out namespace initialisation [try #6]
Message-ID: <20060307115210.GA30275@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
	aviro@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
	linux-kernel@vger.kernel.org
References: <20060307113352.23330.80913.stgit@warthog.cambridge.redhat.com> <20060307113357.23330.4136.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307113357.23330.4136.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 11:33:57AM +0000, David Howells wrote:
> The attached patch abstracts out the namespace initialisation so that temporary
> namespaces can be set up elsewhere.

Doing this inline is still wrong, as mentioned last time.

