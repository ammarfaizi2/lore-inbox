Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261825AbSJQIAf>; Thu, 17 Oct 2002 04:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbSJQIAf>; Thu, 17 Oct 2002 04:00:35 -0400
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:2053 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261825AbSJQIAf>; Thu, 17 Oct 2002 04:00:35 -0400
Date: Thu, 17 Oct 2002 09:05:52 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Device-mapper submission 6/7
Message-ID: <20021017080552.GA2418@fib011235813.fsnet.co.uk>
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com> <20021015214420.GA28738@fib011235813.fsnet.co.uk> <3DAD75AE.7010405@pobox.com> <20021016152047.GA11422@fib011235813.fsnet.co.uk> <3DAD8CC9.9020302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAD8CC9.9020302@pobox.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 11:59:05AM -0400, Jeff Garzik wrote:
> This is a _new_ addition, so from our perspective we want to get it 
> right(tm) and change things now.  I know this differs from your 
> perspective, but that's really a different context and [bluntly] doesn't 
> matter.
> 
> Adding ioctls now and then removing them later is a software engineering 
> no-no.  Save everyone lots of headache and ditch them now.

I'm forced to agree with you, but have a couple of concerns:

Is there anyone out there who is going to argue against using an fs
interface when I submit it ?  Speak now or forever hold your peace !

If dm now misses the feature freeze deadline due to this extra work,
is it going to be possible to still place it in 2.5 at a later date ?
(dm with an ioctl interface is better than no dm at all).

- Joe
