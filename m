Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264946AbSJPH0N>; Wed, 16 Oct 2002 03:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264949AbSJPH0N>; Wed, 16 Oct 2002 03:26:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20133 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264946AbSJPH0L>;
	Wed, 16 Oct 2002 03:26:11 -0400
Date: Wed, 16 Oct 2002 09:31:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
Message-ID: <20021016073154.GF4827@suse.de>
References: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15 2002, Linus Torvalds wrote:
> 
> A huge merging frenzy for the feature freeze, although I also spent a few
> days getting rid of the need for ide-scsi.c and the SCSI layer to burn
> CD-ROM's with the IDE driver (it still needs an update to cdrecord, I sent 
> those off to the maintainer).

I put cdrecord rpms up here:

*.kernel.org/pub/linux/kernel/people/axboe/tools

The binary rpms are built on SuSE 8.1, there's a source rpm there too
though. This is 1.11a37 with Linus patch that allows you do to

	cdrecord -dev=/dev/hdc -data -....

and burn without die-scsi.

-- 
Jens Axboe

