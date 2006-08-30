Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWH3MEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWH3MEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWH3MEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:04:13 -0400
Received: from brick.kernel.dk ([62.242.22.158]:60529 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750876AbWH3MEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:04:11 -0400
Date: Wed, 30 Aug 2006 14:06:59 +0200
From: Jens Axboe <axboe@kernel.dk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] BLOCK: Permit block layer to be disabled [try #6]
Message-ID: <20060830120659.GA7331@kernel.dk>
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29 2006, David Howells wrote:
> 
> This set of patches permits the block layer to be disabled and removed from
> the compilation such that it doesn't take up any resources on systems that
> don't need it.
> 
> This set of patches is against the block git tree.
> 
> Changes in [try #6]:
> 
>  (*) Remove all traces of block_sync_page() from AFS.
> 
> Changes in [try #5]:
> 
>  (*) Update to block GIT tree for 2.6.18-rc5.
> 
>  (*) Make USB_STORAGE depend on SCSI rather than selecting it.
> 
>  (*) Remove dependencies on BLOCK where there are also dependencies on SCSI.

Looks fine to me know, committed.

-- 
Jens Axboe

