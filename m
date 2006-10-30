Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161429AbWJ3TCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161429AbWJ3TCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161418AbWJ3TCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:02:43 -0500
Received: from brick.kernel.dk ([62.242.22.158]:31292 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161413AbWJ3TCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:02:41 -0500
Date: Mon, 30 Oct 2006 20:04:21 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Mark Lord <liml@rtr.ca>
Cc: Arjan van de Ven <arjan@infradead.org>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Message-ID: <20061030190421.GM14055@kernel.dk>
References: <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk> <45463C5B.7070900@rtr.ca> <45464064.2090108@rtr.ca> <20061030181645.GF14055@kernel.dk> <454644C1.4080702@rtr.ca> <20061030185214.GH14055@kernel.dk> <45464BA0.8070106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45464BA0.8070106@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2006, Mark Lord wrote:
> Jens Axboe wrote:
> >
> >Bingo, that's a lot better! So that's the real bug, I'm guessing this
> >got introduced when the ioprio stuff got juggled around recently. Pretty
> >straight forward, this should fix it for you.
> 
> And it does indeed fix it, thanks!

Cool, thanks for retesting Mark! Patch is sent upstream, so should
appear in the next snapshots and -rc.

-- 
Jens Axboe

