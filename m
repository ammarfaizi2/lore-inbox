Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264016AbTE0STQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbTE0SSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:18:12 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:47622 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264016AbTE0SRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:17:10 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jens Axboe <axboe@suse.de>
Cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030527182126.GO845@suse.de>
References: <1053972773.2298.177.camel@mulgrave>
	<20030526181852.GL845@suse.de> <1053974830.1768.190.camel@mulgrave>
	<20030526190707.GM845@suse.de> <1053976644.2298.194.camel@mulgrave>
	<20030526193327.GN845@suse.de> <20030527123901.GJ845@suse.de>
	<1054045594.1769.24.camel@mulgrave> <20030527171605.GL845@suse.de>
	<1054058946.1769.223.camel@mulgrave>  <20030527182126.GO845@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 27 May 2003 14:30:20 -0400
Message-Id: <1054060221.1974.228.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-27 at 14:21, Jens Axboe wrote:
> Oh yes you are right. How does the attached look? With real_max_depth,
> that should work as well since we'll only ever alloc a bigger area.

That looks perfect.  You submit the block layer changes, I'll plumb it
into SCSI and we can try it out....just as soon as I convert the one
SCSI driver that uses the block queue tags to do dynamic queue
adjustment...

James


