Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269968AbTGUMTh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269981AbTGUMTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:19:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23777 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269968AbTGUMTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:19:34 -0400
Date: Mon, 21 Jul 2003 14:33:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Sean <seanlkml@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  "blk: request botched" error on floppy write
Message-ID: <20030721123331.GE10781@suse.de>
References: <794001c34e24$d8f83440$7f0a0a0a@lappy7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794001c34e24$d8f83440$7f0a0a0a@lappy7>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19 2003, Sean wrote:
> The floppy drive appears to be working for some people with the 
> 2.6 kernel as is.  However, there have also been reports of some
> problems (see http://bugme.osdl.org/show_bug.cgi?id=654 )
> 
> The attached patch against 2.6.0-test1 fixes the problem on all the 
> machines i've tested.

So floppy has a problem with clustered requests? Your patch doesn't fix
that bug, it masks it.

Question is, if we should just accept that and move on. I mean, who
really cares?

-- 
Jens Axboe

