Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbUKDJXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbUKDJXO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 04:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUKDJXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 04:23:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60310 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262146AbUKDJW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 04:22:28 -0500
Date: Thu, 4 Nov 2004 10:21:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permit READ_BUFFER_CAPACITY in SG_IO command table
Message-ID: <20041104092158.GF14993@suse.de>
References: <200411040535.42286.dsd@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411040535.42286.dsd@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04 2004, Daniel Drake wrote:
> Hi,
> 
> While burning CD's on 2.6.9 with cdrdao, I noticed it complaining repeatedly:
>  ERROR: Read buffer capacity failed.
> 
> It tries to read the buffer capacity (MMC command 0x5c) in order to produce a 
> percentage reading of how full the buffer is.
> 
> This patch permits the READ_BUFFER_CAPACITY command again. Please apply.
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>

Looks fine, thanks!

-- 
Jens Axboe

