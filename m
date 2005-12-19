Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVLSTeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVLSTeV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbVLSTeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:34:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11579 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964898AbVLSTeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:34:20 -0500
Date: Mon, 19 Dec 2005 20:35:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Ben Collins <bcollins@ubuntu.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc6] block: Make CDROMEJECT more robust
Message-ID: <20051219193557.GM3734@suse.de>
References: <20051219153236.GA10905@swissdisk.com> <20051219193508.GL3734@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219193508.GL3734@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19 2005, Jens Axboe wrote:
> > This patch fixes the WRITE vs READ issue, and also sends the extra two
> > commands. Anyone with an iPod connected via USB (not sure about firewire)
> > should be able to reproduce this issue, and verify the patch.
> 
> The bug was in the SCSI layer, and James already has the fix integrated
> for that. It really should make 2.6.15, James are you sending it upwards
> for that?

I missed the fact that it is already in -rc6, so no problems there.

-- 
Jens Axboe

