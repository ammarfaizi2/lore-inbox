Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLGROF>; Thu, 7 Dec 2000 12:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLGRNz>; Thu, 7 Dec 2000 12:13:55 -0500
Received: from zeus.kernel.org ([209.10.41.242]:15628 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129267AbQLGRNk>;
	Thu, 7 Dec 2000 12:13:40 -0500
Date: Thu, 7 Dec 2000 16:41:25 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Reto Baettig <baettig@scs.ch>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: 64bit offsets for block devices ?
Message-ID: <20001207164125.F13934@redhat.com>
In-Reply-To: <3A2E5227.693121F@scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A2E5227.693121F@scs.ch>; from baettig@scs.ch on Wed, Dec 06, 2000 at 06:50:15AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 06, 2000 at 06:50:15AM -0800, Reto Baettig wrote:

> Imagine we have a virtual disk which provides a 64bit (sparse) address
> room. Unfortunately we can not use it as a block device because in a lot
> of places (including buffer_head structure), we're using a long or even
> an int for the block number. 
> 
> Is there any way of getting a standardized way of doing I/O to a block
> device which could handle 64bit addresses for the block number?

It's on the agenda for urgent fixing in 2.5 (along with
block-dev-layer support for high memory on Intel, and merging in
better disk profiling, and a general cleanup of the data tables in
ll_rw_blk.c).

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
