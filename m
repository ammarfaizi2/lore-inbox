Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbUCRUKH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUCRUKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:10:07 -0500
Received: from ns.suse.de ([195.135.220.2]:54474 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262918AbUCRUKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:10:02 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Peter Zaitsev <peter@mysql.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040318194745.GA2314@suse.de>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
	 <20040318194745.GA2314@suse.de>
Content-Type: text/plain
Message-Id: <1079640699.11062.1.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 15:11:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 14:47, Jens Axboe wrote:

> > With 2.6.3 I have  both existing file and new file to complete in less
> > than 1 second. 
> 
> I believe some missed set_page_writeback() calls caused fsync() to never
> really wait on anything, pretty broken... IIRC, it's fixed in latest
> -mm, or maybe it's just pending for next release.

This should have only been broken in -mm.  Which kernels exactly are you
comparing?  Maybe the 3ware array defaults to different writecache
settings under 2.6?

-chris


