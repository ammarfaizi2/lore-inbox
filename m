Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262213AbSIZHBH>; Thu, 26 Sep 2002 03:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSIZHBH>; Thu, 26 Sep 2002 03:01:07 -0400
Received: from holomorphy.com ([66.224.33.161]:60323 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262213AbSIZHBG>;
	Thu, 26 Sep 2002 03:01:06 -0400
Date: Thu, 26 Sep 2002 00:06:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, patman@us.ibm.com,
       andmike@us.ibm.com
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020926070615.GX22942@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, patman@us.ibm.com,
	andmike@us.ibm.com
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com> <20020926064455.GC12862@suse.de> <20020926065951.GD12862@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020926065951.GD12862@suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 08:59:51AM +0200, Jens Axboe wrote:
> BTW, for SCSI, it would be nice to first convert more drivers to use the
> block level queued tagging. That would provide us with a much better
> means to control starvation properly on SCSI as well.

Hmm, qlogicisp.c isn't really usable because the disks are too slow, it
needs bounce buffering, and nobody will touch the driver (and I don't
seem to be able to figure out what's going on with it myself), and the
FC stuff seems to need out-of-tree drivers to work. I wonder if I some
help converting them to this might be found.


Thanks,
Bill
