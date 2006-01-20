Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWATIJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWATIJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWATIJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:09:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12325 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750713AbWATIJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:09:51 -0500
Date: Fri, 20 Jan 2006 09:11:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Nate Diller <nate.diller@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com, seelam@cs.utep.edu,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] Default iosched fixes (was: Fall back io scheduler for 2.6.15?)
Message-ID: <20060120081145.GD4213@suse.de>
References: <5c49b0ed0601191604p4fa53404r783b3a703e922b13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0601191604p4fa53404r783b3a703e922b13@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19 2006, Nate Diller wrote:
> My previous default iosched patch did a poor job dealing with the
> 'elevator=' boot-time option.  Jens' recent solution would fail if the
> selected default were compiled as a module, and I find that scenario
> useful for debugging.  This patch dynamically evaluates which default
> to use, and emits suitable error messages when the requested scheduler
> is not available.  It also indicates the compiled-in default scheduler
> at registration time, and includes a version of Chuck Ebbert's 'as' ->
> 'anticipatory' compatability patch.
> 
> Tested for a range of boot options on 2.6.13-rc5-mm1, should apply to
> any recent kernel.

Your patch doesn't apply at all, the file has even been moved. Please
test a 2.6.15 or newer kernel and you'll find that the problem you
envision doesn't exist.

-- 
Jens Axboe

