Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVLZXWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVLZXWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 18:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVLZXWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 18:22:14 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:476 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751096AbVLZXWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 18:22:13 -0500
Subject: Re: 2.6.15rc6: ide oops+panic
From: Lee Revell <rlrevell@joe-job.com>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, Jens Axboe <axboe@suse.de>
In-Reply-To: <43B07A17.5040707@domdv.de>
References: <43AB20DA.2020506@domdv.de>
	 <20051223053621.6c437cee.akpm@osdl.org>  <43B07A17.5040707@domdv.de>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 18:27:22 -0500
Message-Id: <1135639643.8293.91.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 00:17 +0100, Andreas Steinmetz wrote:
> Andrew Morton wrote:
> > Thanks.  Are you able to identify the most-recent kernel version which
> > didn't do this?
> > 
> 
> Bartlomiej's workaround (mount with "barrier=0") doesn't seem to help to
> workaround the problem. I had one BUG/oops/panic (the same as reported)
> after 96 hours of uptime and another one after only a few minutes of uptime.
> 
> Some more info on the disk setup (all partitions including root):
> 
> hda(1)/hdc(1)/hde(2) <-> 2x md raid5 <-> dm-crypt <-> lvm2 <-> ext3

Stack overflow?

Lee

