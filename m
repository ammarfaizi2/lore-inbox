Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTGFUzz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 16:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTGFUzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 16:55:55 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:37638 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263462AbTGFUzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 16:55:54 -0400
Date: Sun, 6 Jul 2003 17:10:05 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Paul Clements <Paul.Clements@steeleye.com>, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHES 2.5.74-mm2] misc. nbd cleanups/fixes
In-Reply-To: <3F08879D.4070300@pobox.com>
Message-ID: <Pine.LNX.4.10.10307061707551.764-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003, Jeff Garzik wrote:

> Paul Clements wrote:
> > The two attached patches are:
> > 
> > 1) nbd-remove_open_release.diff - remove the unneeded nbd_open and
> > nbd_release functions
> 
> Please remove the unneeded ->refcnt member as well.

Yep, I forgot to do that...new patch on the way...

 
> > 2) nbd-block_layer_compat.diff - ensure that nbd and the block layer
> > agree about device block sizes and total device sizes
> 
> Use set_blocksize, please.

OK, I've done that in this next patch, also on the way...

 
> Also, please split up your patches further.  The Linux (Linus?) standard 
> is one patch per email...  Also, attachments are discouraged, though not 
> a "no no" because of various broken corporate email systems...

OK, thanks...

--
Paul

