Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUCRLHR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbUCRLHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:07:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29568 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262503AbUCRLHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:07:12 -0500
Date: Thu, 18 Mar 2004 12:07:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Eric Valette <eric.valette@free.fr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.5-rc1-mm2 : Badness in elv_requeue_request at drivers/block/elevator.c:157
Message-ID: <20040318110709.GI22234@suse.de>
References: <40596FC5.3080703@free.fr> <20040318100222.GE22234@suse.de> <20040318100606.GG22234@suse.de> <40597BF2.80807@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40597BF2.80807@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2004, Eric Valette wrote:
> Jens Axboe wrote:
> 
> >>Ah damn, requeue through blk_insert_request... Let me think about this
> >>a bit, I'll post a fix for you.
> >
> >
> >Does this work for you?
> 
> At least it does avoid the message at boot time :-) Thanks for your 
> quick reply. Who still thinks OSS is not supported?

Great, thanks for testing.

-- 
Jens Axboe

