Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265687AbUA1BCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 20:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUA1BCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 20:02:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63202 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265687AbUA1BCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 20:02:08 -0500
Date: Wed, 28 Jan 2004 02:02:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MO: opening for write in cdrom.c
Message-ID: <20040128010206.GE11683@suse.de>
References: <20040128000216.GD11683@suse.de> <Pine.LNX.4.44.0401280159040.843-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401280159040.843-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28 2004, Pascal Schmidt wrote:
> On Wed, 28 Jan 2004, Jens Axboe wrote:
> 
> > Alright, this is your version plus write protect io error handling.
> > Could you check if this works for you?
> 
> Works for me. I've tested the fallback by making mo_open_write always 
> succeed and then inserting a write-protected disc.
> 
> I now only get one error report from the drive, the rest of the
> writes are correctly denied before hitting the drive.

Excellent, thanks a lot for the work and testing.

-- 
Jens Axboe

