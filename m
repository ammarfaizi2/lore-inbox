Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbSKKQGO>; Mon, 11 Nov 2002 11:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265742AbSKKQGO>; Mon, 11 Nov 2002 11:06:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34453 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265339AbSKKQGO>;
	Mon, 11 Nov 2002 11:06:14 -0500
Date: Mon, 11 Nov 2002 17:12:59 +0100
From: Jens Axboe <axboe@suse.de>
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47 hangs while checking hda on PII laptop
Message-ID: <20021111161259.GB838@suse.de>
References: <20021111104153.A8017@ma-northadams1b-126.bur.adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021111104153.A8017@ma-northadams1b-126.bur.adelphia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11 2002, Eric Buddington wrote:
> This is 2.5.47, compiled for a PII laptop (Omnibook 4100) with
> gcc-3.2. I fixed an earlier boot panic by disabling IDE-TCQ, but now
> it hangs in the hda check (shown below) I waited at least 2 minutes
> for it to unhang.
> 
> Below is as much of the boot messages as I could capture; I don't know
> if the hdc error is significant (the drive had no media), but pulling
> the CD-ROM did not prevent the hda hang in a subsequent boot.

Try disabling the acpi crap

-- 
Jens Axboe

