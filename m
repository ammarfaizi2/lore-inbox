Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265345AbTLSG6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 01:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbTLSG6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 01:58:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57510 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265345AbTLSG6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 01:58:36 -0500
Date: Fri, 19 Dec 2003 07:58:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6: ATAPI MO drive support
Message-ID: <20031219065831.GU2069@suse.de>
References: <Pine.LNX.4.44.0312190022480.1134-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312190022480.1134-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19 2003, Pascal Schmidt wrote:
> 
> Hi!
> 
> The below patch is needed to support ATAPI MO drives in 2.6. ide-scsi
> doesn't work any more for this, so ide-cd has to take over the job of
> running the MO drive. Without this, there is no way to write to an
> ATAPI MO drive.
> 
> This patch has been discussed with Linus and Jens already around test9
> time and it was agreed this is the right way to go about it. I have
> rediffed it against 2.6.0. Compiles, runs, works just fine for me.

Thanks for reminding us, I'm fine with the patch and it should be
applied.

-- 
Jens Axboe

