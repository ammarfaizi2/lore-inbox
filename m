Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUCSHhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 02:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUCSHhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 02:37:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27294 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261421AbUCSHhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 02:37:23 -0500
Date: Fri, 19 Mar 2004 08:37:17 +0100
From: Jens Axboe <axboe@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Eric Valette <eric.valette@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2 : Badness in elv_requeue_request at drivers/block/elevator.c:157
Message-ID: <20040319073716.GX22234@suse.de>
References: <40596FC5.3080703@free.fr> <20040318100222.GE22234@suse.de> <20040318100606.GG22234@suse.de> <20040318231957.GA3867@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318231957.GA3867@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19 2004, J.A. Magallon wrote:
> 
> On 03.18, Jens Axboe wrote:
> > On Thu, Mar 18 2004, Jens Axboe wrote:
> > > On Thu, Mar 18 2004, Eric Valette wrote:
> > > > I have this message two times as I have two adaptec controllers...
> > > > 
> 
> I have a similar but different place oops. My box was dog slow with -mm2,
> and syslog was flooded with:
> 
> Mar 18 20:00:00 werewolf kernel: Badness in elv_remove_request at drivers/block/elevator.c:249
> Mar 18 20:00:00 werewolf kernel: Call Trace:
> Mar 18 20:00:00 werewolf kernel:  [elv_remove_request+156/160] elv_remove_request+0x9c/0xa0

Tell me a bit about your io setup please, ide/scsi, raid, what?

-- 
Jens Axboe

