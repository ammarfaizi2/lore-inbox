Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbTA0Nyd>; Mon, 27 Jan 2003 08:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbTA0Nyd>; Mon, 27 Jan 2003 08:54:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61358 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266952AbTA0Ny3>;
	Mon, 27 Jan 2003 08:54:29 -0500
Date: Mon, 27 Jan 2003 15:03:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ATA TCQ  problems in 2.5.59
Message-ID: <20030127140330.GJ889@suse.de>
References: <200301261605.00539.roy@karlsbakk.net> <Pine.LNX.4.44.0301261116390.16853-100000@coffee.psychology.mcmaster.ca> <20030126162120.GO889@suse.de> <200301271450.59304.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301271450.59304.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27 2003, Roy Sigurd Karlsbakk wrote:
> > > but it's a flag, not a count.  use CONFIG_BLK_DEV_IDE_TCQ_DEPTH
> > > if you want something other than the default depth of 1.
> >
> > It's a flag, correct. The default depth is 32 though, not 1. And with
> > newer hdparms you can use -Q to set/query the tag depth of the drive. Be
> > careful with that though, it's not too well tested. IDE TCQ in 2.5 needs
> > a bit of work, I hope to do so soonish...
> 
> but shouldn't the 'echo using_tcq:32' be equivilent of hdparm -Q?

Yes, doesn't that work?

-- 
Jens Axboe

