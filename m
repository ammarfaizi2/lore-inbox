Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVCWPVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVCWPVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVCWPVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:21:19 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:54656 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261648AbVCWPU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:20:28 -0500
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Tejun Heo <htejun@gmail.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050323071920.GJ24105@suse.de>
References: <20050323021335.960F95F8@htj.dyndns.org>
	 <20050323021335.4682C732@htj.dyndns.org>
	 <1111550882.5520.93.camel@mulgrave> <4240F5A9.80205@gmail.com>
	 <20050323071920.GJ24105@suse.de>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 09:20:12 -0600
Message-Id: <1111591213.5441.19.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 08:19 +0100, Jens Axboe wrote:
> It is not the oops I am getting. When I get a few minutes today, I'll
> reproduce with vanilla and post it here.

Well, I have news too.  Unfortunately, the python script I posted is
hanging in D wait.  When I tested all of this out (with a similar
script) in the 2.6.10 timeframe, it wasn't doing this, so we have some
other problem introduced into the stack since then, sigh.

Also it means my test isn't effective, so I need to track down the
open/close hang before I can make progress.

James


