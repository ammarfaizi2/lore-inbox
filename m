Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTEFClb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbTEFClb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:41:31 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:46351
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262280AbTEFClb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:41:31 -0400
Date: Mon, 5 May 2003 19:53:56 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1 VM swaps out too much
Message-ID: <20030506025356.GD8350@matchmail.com>
Mail-Followup-To: Rene Rebe <rene.rebe@gmx.net>,
	linux-kernel@vger.kernel.org
References: <20030503.215534.846937682.rene.rebe@gmx.net> <20030505.204036.596526358.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505.204036.596526358.rene.rebe@gmx.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 08:40:36PM +0200, Rene Rebe wrote:
> Hi,
> 
> 2.5.68 is much smoother, quite less swap is used, my editors are not
> pulled out of the swap all the time:
> 
> $ free
>              total       used       free     shared    buffers     cached
> Mem:        515848     505804      10044          0      92808     173876
> -/+ buffers/cache:     239120     276728
> Swap:       524624      35612     489012

You will notice that -aa is better and -rmap is even better still.

I can run badblocks on two drives without very much swapping on 192MB with
-rmap15[aeg]
