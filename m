Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSKSNBw>; Tue, 19 Nov 2002 08:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbSKSNBv>; Tue, 19 Nov 2002 08:01:51 -0500
Received: from holomorphy.com ([66.224.33.161]:40164 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264644AbSKSNBu>;
	Tue, 19 Nov 2002 08:01:50 -0500
Date: Tue, 19 Nov 2002 05:06:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: scsi in 2.5.48
Message-ID: <20021119130601.GM23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>,
	lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
	James Bottomley <James.Bottomley@steeleye.com>
References: <3DD8AF65.BF2EF851@digeo.com> <3DD8B6B9.E9EAD230@digeo.com> <20021118135614.GA834@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118135614.GA834@suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>> Appears to be DOA.  Just a simple mke2fs hangs in get_request_wait().

On Mon, Nov 18 2002, Andrew Morton wrote:
>> This makes it work again.

On Mon, Nov 18, 2002 at 02:56:14PM +0100, Jens Axboe wrote:
> Right fix would be something ala:

This solves my free_initmem() deadlock, which for some reason I assumed
to be a problem of a lower-level nature.


Bill
