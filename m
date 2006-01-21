Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWAULin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWAULin (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 06:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWAULin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 06:38:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25453 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932123AbWAULim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 06:38:42 -0500
Date: Sat, 21 Jan 2006 12:40:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Nate Diller <nate.diller@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com, seelam@cs.utep.edu,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2][RESEND] Default iosched fixes (was: Fall back io scheduler for 2.6.15?)
Message-ID: <20060121114028.GQ13429@suse.de>
References: <5c49b0ed0601191604p4fa53404r783b3a703e922b13@mail.gmail.com> <20060120081145.GD4213@suse.de> <5c49b0ed0601201517h3126ac8dp931bab93a85bf9c5@mail.gmail.com> <5c49b0ed0601201524x26225a77k94a1eb95bc601883@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0601201524x26225a77k94a1eb95bc601883@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20 2006, Nate Diller wrote:
> Jens has decided that allowing the default scheduler to be a module is
> a bug, and should not be allowed under kconfig.  However, I find that
> scenario useful for debugging, and wish for the kernel to be able to
> handle this situation without OOPSing, if I enable such an option in
> the .config directly.  This patch dynamically checks for the presence
> of the compiled-in default, and falls back to no-op, emitting a
> suitable error message, when the default is not available
> 
> Tested for a range of boot options on 2.6.16-rc1-mm2.

NAK, if you find it useful for testing, keep this patch along with the
patch that enables you to config the kernel that way.

-- 
Jens Axboe

