Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318172AbSHNHkO>; Wed, 14 Aug 2002 03:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319238AbSHNHkO>; Wed, 14 Aug 2002 03:40:14 -0400
Received: from cmailm2.svr.pol.co.uk ([195.92.193.210]:17419 "EHLO
	cmailm2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S318172AbSHNHkN>; Wed, 14 Aug 2002 03:40:13 -0400
Date: Wed, 14 Aug 2002 08:43:37 +0100
To: Andrew Morton <akpm@zip.com.au>
Cc: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] simplify b_inode usage
Message-ID: <20020814074337.GB1045@fib011235813.fsnet.co.uk>
References: <20020813171024.A4365@lst.de> <3D5975B2.66B4B215@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5975B2.66B4B215@zip.com.au>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 02:10:10PM -0700, Andrew Morton wrote:
> Also, Joe Thornber needs to add another pointer to struct buffer_head
> for LVM2 reasons.  If we collapse b_inode into a b_flags bit then
> Joe gets his pointer for free (bh stays at 48 bytes on ia32).

This change is in the latest -ac.

- Joe
