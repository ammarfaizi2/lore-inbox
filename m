Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263296AbUCTKFc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbUCTKFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:05:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49890 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263296AbUCTKFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:05:24 -0500
Date: Sat, 20 Mar 2004 11:05:17 +0100
From: Jens Axboe <axboe@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Eric Valette <eric.valette@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2 : Badness in elv_requeue_request at drivers/block/elevator.c:157
Message-ID: <20040320100517.GD2711@suse.de>
References: <40596FC5.3080703@free.fr> <20040318100222.GE22234@suse.de> <20040318100606.GG22234@suse.de> <20040318231957.GA3867@werewolf.able.es> <20040319073716.GX22234@suse.de> <20040319232548.GA29690@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319232548.GA29690@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20 2004, J.A. Magallon wrote:
> 
> On 03.19, Jens Axboe wrote:
> > On Fri, Mar 19 2004, J.A. Magallon wrote:
> > > 
> > > On 03.18, Jens Axboe wrote:
> > > > On Thu, Mar 18 2004, Jens Axboe wrote:
> > > > > On Thu, Mar 18 2004, Eric Valette wrote:
> > > > > > I have this message two times as I have two adaptec controllers...
> > > > > > 
> > > 
> > > I have a similar but different place oops. My box was dog slow with -mm2,
> > > and syslog was flooded with:
> > > 
> > > Mar 18 20:00:00 werewolf kernel: Badness in elv_remove_request at drivers/block/elevator.c:249
> > > Mar 18 20:00:00 werewolf kernel: Call Trace:
> > > Mar 18 20:00:00 werewolf kernel:  [elv_remove_request+156/160] elv_remove_request+0x9c/0xa0
> > 
> > Tell me a bit about your io setup please, ide/scsi, raid, what?
> > 
> 
> Simple scsi (no raid, no md), on an 2940.
> Anyways, the patch you posted made everything work fine again.
> Thanks. 

Super, thanks for confirming.

-- 
Jens Axboe

