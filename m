Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265629AbTFSN6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 09:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265631AbTFSN6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 09:58:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34758 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265629AbTFSN6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 09:58:12 -0400
Date: Thu, 19 Jun 2003 16:07:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Andy Polyakov <appro@fy.chalmers.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Regarding drivers/ide/ide-cd.c in 2.5.72
Message-ID: <20030619140735.GU6445@suse.de>
References: <3EEF8E2E.5E14946E@fy.chalmers.se> <20030619122010.GL6445@suse.de> <3EF1C4C8.98300966@fy.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF1C4C8.98300966@fy.chalmers.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19 2003, Andy Polyakov wrote:
> > > ... In the nutshell the problem is that [as it is
> > > now] every failed SG_IO request is replayed second time without data
> > > transfer. ... Suggested patch
> > > overcomes this problem by immediately purging the failed SG_IO request
> > > from the request queue.
> > 
> > Patch looks fine, care to resend actually trying to follow the style in
> > the file in question?
> 
> Revised to my best ability for follow the coding style of file in
> question. A:-)

Much better, thanks :)

-- 
Jens Axboe

