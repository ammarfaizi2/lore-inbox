Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUHOXzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUHOXzE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267276AbUHOXzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:55:04 -0400
Received: from zero.aec.at ([193.170.194.10]:42501 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267278AbUHOXzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:55:00 -0400
To: Mark Lord <lkml@rtr.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: new tool:  blktool
References: <2tATw-7md-25@gated-at.bofh.it> <2tCLz-dp-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 16 Aug 2004 01:54:57 +0200
In-Reply-To: <2tCLz-dp-3@gated-at.bofh.it> (Mark Lord's message of "Mon, 16
 Aug 2004 01:40:05 +0200")
Message-ID: <m3wu00c5ym.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord <lkml@rtr.ca> writes:

> hdparm works for some SCSI devices already, and support for
> more is already on the way.  I imagine I can have it handle
> whatever new ioctls() are being provided from libata as well.

I can see Jeff's point that the one letter options are not 
very nice (I often have to look them up in the man page too ...) 
And it's probably true that it will soon run out of letters.

Any chance you could add GNU style long options using getopt_long()?

-Andi

