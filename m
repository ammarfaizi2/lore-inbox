Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUEVTbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUEVTbi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 15:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUEVTbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 15:31:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:20105 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261851AbUEVTbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 15:31:36 -0400
Subject: Re: [PATCH] ext3 barrier bits
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20040522011139.01a7da10.akpm@osdl.org>
References: <20040521093207.GA1952@suse.de>
	 <20040521023807.0de63c7a.akpm@osdl.org> <20040521100234.GK1952@suse.de>
	 <20040521235044.6160cccb.akpm@osdl.org> <20040522073540.GO1952@suse.de>
	 <20040522011139.01a7da10.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1085254293.9467.5026.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 22 May 2004 15:31:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-22 at 04:11, Andrew Morton wrote:
> May as well cc lkml on this.  It's to do with the disk write barrier
> implementation.

> - Does reiserfs support `mount -o remount,barrier=flush'? and "=none"?
> 
Yes...there are no messages to clue the user in, but it does happen.

> - How do I test the "oh, barriers aren't working" fallback code in ext3?
> 
Jens suggested mounting with barriers on for scsi, that's what I've been
doing.  I also did some crash tests on scsi to make sure the io really
is happening when barriers fail.

-chris


