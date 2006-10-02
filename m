Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWJBQwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWJBQwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWJBQwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:52:13 -0400
Received: from brick.kernel.dk ([62.242.22.158]:21820 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932334AbWJBQwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:52:11 -0400
Date: Mon, 2 Oct 2006 18:51:38 +0200
From: Jens Axboe <axboe@kernel.dk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] BLOCK: Fix linux/compat.h's use sigset_t
Message-ID: <20061002165137.GK5670@kernel.dk>
References: <20061002131231.19879.19860.stgit@warthog.cambridge.redhat.com> <20061002131234.19879.34671.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002131234.19879.34671.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02 2006, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Make linux/compat.h #include asm/signal.h to gain a definition of
> sigset_t so that it can externally declare sigset_from_compat().
> 
> This has been compile-tested for i386, x86_64, ia64, mips, mips64,
> frv, ppc and ppc64 and run-tested on frv.

Ack both patches, thanks David.

-- 
Jens Axboe

