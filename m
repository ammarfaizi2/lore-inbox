Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbTIHOeA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbTIHOeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:34:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64642 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262466AbTIHOd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:33:57 -0400
Date: Mon, 8 Sep 2003 16:34:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [blockdevices/NBD] huge read/write-operations are splitted by the kernel
Message-ID: <20030908143408.GT840@suse.de>
References: <bjgh6a$82o$1@sea.gmane.org> <20030908085802.GH840@suse.de> <bji001$sop$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bji001$sop$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08 2003, Sven Köhler wrote:
> >You'll probably find that if you bump the max_sectors count if your
> >drive to 256 from 255 (that is the default if you haven't set it), then
> >you'll see 128kb chunks all the time.
> >
> >See max_sectors[] array.
> 
> To make it clear:
> the kernel will never read or write more sectors at once than specified 
> in the max_sectors array (where every device has its own value), right?

Correct

-- 
Jens Axboe

