Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275219AbTHGICy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 04:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275220AbTHGICy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 04:02:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10669 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S275219AbTHGICw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 04:02:52 -0400
Date: Thu, 7 Aug 2003 10:02:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: cb-lkml@fish.zetnet.co.uk, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Disk priority dependend on nice level...
Message-ID: <20030807080251.GY7982@suse.de>
References: <20030806232810.GA1623@elf.ucw.cz> <20030806234036.GA209@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806234036.GA209@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07 2003, Pavel Machek wrote:
> Hi!
> 
> > I ported `subj` to 2.6.0-test2. I do not yet have idea if it works,
> > but it compiles ;-).
> 
> It compiles, it event boots, but it does not seem to have much effect
> :-(.

Now that the queue reference counting is in the current bk tree, we are
that much closer to real modular io schedulers. I'll post the cfq with
priorities for that.

-- 
Jens Axboe

