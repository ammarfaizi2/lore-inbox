Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVIHA4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVIHA4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 20:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVIHA43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 20:56:29 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:24722 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932490AbVIHA43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 20:56:29 -0400
Subject: Re: [GIT PATCH] SCSI merge for 2.6.13
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>, Greg KH <greg@kroah.com>
In-Reply-To: <Pine.LNX.4.58.0509071743380.11102@g5.osdl.org>
References: <1126053452.5012.28.camel@mulgrave>
	 <Pine.LNX.4.58.0509071730490.11102@g5.osdl.org>
	 <Pine.LNX.4.58.0509071738050.11102@g5.osdl.org>
	 <Pine.LNX.4.58.0509071743380.11102@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 19:56:19 -0500
Message-Id: <1126140979.4823.65.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 17:49 -0700, Linus Torvalds wrote:
> > Quite frankly, what's the point in asking people to pull a tree that is 
> > known to not compile?
> 
> Btw, I see the patch that is supposed to fix it, but I'm in no position to
> know whether it's even acceptable to basically double the size of the
> "struct klist", for example. There may be a good reason why Greg hasn't 
> been merging the klist stuff, and just assuming that they are merged not 
> only screws up everybody down-stream, it's not necessarily valid in the 
> first place.
> 
> In other words, I think I will have to just revert the commit that
> introduces this bogus "assume a patch that wasn't merged" (commit ID
> 2b7d6a8cb9718fc1d9e826201b64909c44a915f4) for now.
> 
> And once more strongly complain about it getting sent to me in the first
> place since it was known to not even compile.

He's been on holiday, but he did send me a sign off for that particular
patch so I could put it through the SCSI tree.  However, because Andrew
sent you the patch before I could do this, there didn't seem to be any
necessity ...

James


