Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVCOPsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVCOPsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVCOPsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:48:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12443 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261328AbVCOPsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:48:09 -0500
Date: Tue, 15 Mar 2005 16:47:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: current linus bk, error mounting root
Message-ID: <20050315154751.GB4237@suse.de>
References: <20050310075049.GA30243@suse.de> <9e4733910503100658ff440e3@mail.gmail.com> <20050310153151.GY2578@suse.de> <9e473391050310074556aad6b0@mail.gmail.com> <20050310154830.GB2578@suse.de> <9e47339105031007595b1e0cc3@mail.gmail.com> <20050310160155.GC2578@suse.de> <9e4733910503100818df5fb2@mail.gmail.com> <20050310162918.GD2578@suse.de> <9e4733910503150739708a7414@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910503150739708a7414@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15 2005, Jon Smirl wrote:
> Is this problem still being tracked?
> 
> I have figured out a work around of adding a 1 second pause in nash
> after the ata_piix driver is loaded. Something has changed in the
> driver initialization timing such that later stages of boot try to
> access the driver before the driver has created the device without the
> pause.
> 
> I am using Fedora Core 3 un modified except for the addition of the 1
> second pause.

If the /dev showup timing is a problem, you were just lucky that it
worked before and I don't consider it a kernel issue.

-- 
Jens Axboe

