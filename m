Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271033AbRHOFnn>; Wed, 15 Aug 2001 01:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271041AbRHOFnd>; Wed, 15 Aug 2001 01:43:33 -0400
Received: from oit.gatech.edu ([130.207.166.135]:59798 "EHLO oit.gatech.edu")
	by vger.kernel.org with ESMTP id <S271033AbRHOFnP>;
	Wed, 15 Aug 2001 01:43:15 -0400
From: dmaynor@iceland.oit.gatech.edu
Date: Wed, 15 Aug 2001 01:43:28 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.8 Resource leaks + limits
Message-ID: <20010815014328.A15395@iceland.oit.gatech.edu>
In-Reply-To: <3ce801c12548$b7971750$020a0a0a@totalmef> <200108150532.f7F5WGq01653@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108150532.f7F5WGq01653@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Aug 14, 2001 at 10:32:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is why you mainly find per-process stuff in all the limits. 
> 
> Linux has had (for a while now) a "struct user" that is actually quickly
> accessible through a direct pointer off every process that is associated
> with that user, and we could (and _will_) start adding these kinds of
> limits. However, part of the problem is that because the limits haven't
> historically existed, there is also no accepted and nice way of setting
> the limits.
So when you do impose this, where will it be setable, will there be a flat file in /etc
like solaris, or compile time for the kernel?

