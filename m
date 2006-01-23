Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWAWOqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWAWOqN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 09:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWAWOqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 09:46:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41537 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751460AbWAWOqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 09:46:12 -0500
Date: Mon, 23 Jan 2006 15:48:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Tetsuo Takata <takatan.linux@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, doubt@developer.osdl.jp
Subject: Re: [PATCH] enable XFS write barrier
Message-ID: <20060123144803.GJ12773@suse.de>
References: <8e8498350601230640x49d8f866q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e8498350601230640x49d8f866q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23 2006, Tetsuo Takata wrote:
> I found out that the q->ordered is not being set properly on XFS.
> 
> 
> I'm testing the write barrier support of XFS.
> I run the test on kernel 2.6.16-rc1-git4.
> but I found out that the "-o barrier" option is automatically disabled
> in my environment.
> For this reason I could not test the write barrier's execution path.
> 
> The error message in "/var/log/messages" is:
> Filesystem "sdb1": Disabling barriers, not supported by the underlying device
> 
> 
> This patch fixes these bugs.

Woops, thanks!

-- 
Jens Axboe

