Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWCHUcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWCHUcq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWCHUco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:32:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38362 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932449AbWCHUcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:32:42 -0500
Date: Wed, 8 Mar 2006 20:32:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] NFS: Abstract out namespace initialisation [try #7]
Message-ID: <20060308203228.GA6541@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
	aviro@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
	linux-kernel@vger.kernel.org
References: <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com> <20060308203023.25493.6137.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308203023.25493.6137.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 08:30:23PM +0000, David Howells wrote:
> The attached patch abstracts out the namespace initialisation so that temporary
> namespaces can be set up elsewhere.

this _still_ should't be inline.

