Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUBKBYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUBKBYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:24:10 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:36367 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263491AbUBKBW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:22:26 -0500
Date: Wed, 11 Feb 2004 09:25:03 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: linux-kernel@vger.kernel.org
cc: Mike Bell <kernel@mikebell.org>
Subject: Re: devfs vs udev, thoughts from a devfs user
In-Reply-To: <20040210183539.GJ28111@kroah.com>
Message-ID: <Pine.LNX.4.58.0402110914340.3186@wombat.indigo.net.au>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210183539.GJ28111@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004, Greg KH wrote:

> On Tue, Feb 10, 2004 at 03:34:18AM -0800, Mike Bell wrote:
> > I've been reading a lot lately about udev and how it's both very
> > different to and much better than devfs, and with _most_ of the reasons
> > given, I can't see how either is the case. I'd like to lay out why I
> > think that is.
> 
> One final comment:  Can you implement a persistent device naming scheme
> using devfs today?  If so, please show me how you would:
> 	- always name a USB printer the same /dev name no matter when it
> 	  is discovered by the USB core (before or after any other USB
> 	  printer.)
> 	- always name your SCSI disk the same /dev name no matter where
> 	  in the scsi probe sequence it is (yank it out and plug it into
> 	  another place in your scsi rack.)
> 
> This is the main problem that udev solves.  The fact that it also gives
> you a dynamic /dev is just extra goodness.

In his final comment, inocently, he makes the big point.

This a huge deal.

Ian

