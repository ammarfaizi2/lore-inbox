Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTJBHGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 03:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTJBHGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 03:06:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19651 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263268AbTJBHGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 03:06:50 -0400
Date: Thu, 2 Oct 2003 09:06:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Zinx Verituse <zinx@epicsol.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sg-style ATAPI commands in 2.6
Message-ID: <20031002070640.GE6678@suse.de>
References: <20031002065218.GA32246@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031002065218.GA32246@bliss>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02 2003, Zinx Verituse wrote:
> I haven't found much information on the raw ATAPI command
> interface provided in Linux 2.6, but from what I can tell
> it can understand the sg3 interface.
> 
> However, I can't open the device read-write, so mmap'd IO
> is impossible, and unless it's currently horribly insecure,
> I can't write CDs anyway.
> 
> I was just wondering what the desired behavior is, if there's
> a different style interface I'm supposed to use, etc.

Right now, only the SG_IO ioctl is supported. Support for full (as much
as makes sense) sg v3 support is planned and in progress.

-- 
Jens Axboe

