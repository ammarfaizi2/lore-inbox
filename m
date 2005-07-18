Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVGROFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVGROFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 10:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVGROFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 10:05:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9612 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261674AbVGROFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 10:05:36 -0400
Date: Mon, 18 Jul 2005 13:59:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2 and as-iosched
Message-ID: <20050718115929.GE2403@suse.de>
References: <403f93.f22097@family-bbs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403f93.f22097@family-bbs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18 2005, Kenneth Parrish wrote:
> Randy> Need more info.
> 
>         Greetings.  :)
> CONFIG_HZ_ changes the block device elevator time-out values -- didn't see.

I cannot reproduce here with cfq and HZ == 250, the jiffies <-> msec
conversions are working fine. Please provide a proper bug report, did
you change the values and not getting the expected back, or what is
going wrong??

-- 
Jens Axboe

