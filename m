Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVCWP0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVCWP0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVCWP0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:26:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4260 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261624AbVCWP0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:26:00 -0500
Date: Wed, 23 Mar 2005 16:25:50 +0100
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Tejun Heo <htejun@gmail.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
Message-ID: <20050323152550.GB16149@suse.de>
References: <20050323021335.960F95F8@htj.dyndns.org> <20050323021335.4682C732@htj.dyndns.org> <1111550882.5520.93.camel@mulgrave> <4240F5A9.80205@gmail.com> <20050323071920.GJ24105@suse.de> <1111591213.5441.19.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111591213.5441.19.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23 2005, James Bottomley wrote:
> On Wed, 2005-03-23 at 08:19 +0100, Jens Axboe wrote:
> > It is not the oops I am getting. When I get a few minutes today, I'll
> > reproduce with vanilla and post it here.
> 
> Well, I have news too.  Unfortunately, the python script I posted is
> hanging in D wait.  When I tested all of this out (with a similar
> script) in the 2.6.10 timeframe, it wasn't doing this, so we have some
> other problem introduced into the stack since then, sigh.

Let me guess, it is hanging in wait_for_completion()?

> Also it means my test isn't effective, so I need to track down the
> open/close hang before I can make progress.

Makes sense, that is why you are not seeing the crash :)

-- 
Jens Axboe

