Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTL2To4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTL2ToL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:44:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33421 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264104AbTL2TmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:42:12 -0500
Date: Mon, 29 Dec 2003 20:42:04 +0100
From: Jens Axboe <axboe@suse.de>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD burn buffer underruns on 2.6
Message-ID: <20031229194204.GN3086@suse.de>
References: <16366.60194.935861.592797@nycap.rr.com> <20031228153941.GA851@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228153941.GA851@gallifrey>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28 2003, Dr. David Alan Gilbert wrote:
> * craig duncan (duncan@nycap.rr.com) wrote:
> > 
> > Dec 24 08:24:44 cdw kernel: cdrom_newpc_intr: 110 residual after xfer
> 
> Hmm - I'm seeing those just playing an audio CD on 2.6.0:
> 
> cdrom_newpc_intr: 3 residual after xfer

It's a silly debug printk, I'll make sure it gets deleted. This can
happen quite legitimately.

-- 
Jens Axboe

