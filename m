Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbUKVHdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbUKVHdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 02:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbUKVHdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 02:33:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35500 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261966AbUKVHcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 02:32:19 -0500
Date: Mon, 22 Nov 2004 08:28:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] cdrom.c: make several functions static (fwd)
Message-ID: <20041122072833.GK26240@suse.de>
References: <20041121235851.GG13254@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121235851.GG13254@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22 2004, Adrian Bunk wrote:
> 
> The patch forwarded below still applies and compiles against 
> 2.6.10-rc2-mm2 (I've edited it for a trivial context adjustment).
> 
> Please apply or comment on it.
> 
> 
> ----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----
> 
> Date:	Sun, 31 Oct 2004 22:33:19 +0100
> From: Adrian Bunk <bunk@stusta.de>
> To: axboe@suse.de
> Cc: linux-kernel@vger.kernel.org
> Subject: [2.6 patch] cdrom.c: make several functions static
> 
> The patch below makes several functions in cdrom.c static.
> 
> This includes cdrom_is_mrw and cdrom_is_random_writable which were 
> EXPORT_SYMBOL'ed but weren't used anywhere outside of cdrom.h .

They used to, that's why they are non-static. The patch looks fine,
thanks.

-- 
Jens Axboe

