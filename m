Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSGZRjh>; Fri, 26 Jul 2002 13:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317878AbSGZRjh>; Fri, 26 Jul 2002 13:39:37 -0400
Received: from rj.SGI.COM ([192.82.208.96]:11397 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317872AbSGZRjg>;
	Fri, 26 Jul 2002 13:39:36 -0400
Date: Fri, 26 Jul 2002 10:42:58 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock assertion macros for 2.5.28
Message-ID: <20020726174258.GC793866@sgi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020725233047.GA782991@sgi.com> <20020726120918.GA22049@reload.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726120918.GA22049@reload.namesys.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 04:09:18PM +0400, Joshua MacDonald wrote:
> In reiser4 we are looking forward to having a MUST_NOT_HOLD (i.e.,
> spin_is_not_locked) assertion for kernel spinlocks.  Do you know if any
> progress has been made in that direction?

Well, I had that in one version of the patch, but people didn't think
it would be useful.  Maybe you'd like to check out Oliver's comments
at http://marc.theaimsgroup.com/?l=linux-kernel&m=102644431806734&w=2
and respond?  If there's demand for MUST_NOT_HOLD, I'd be happy to add
it since it should be easy.  But if you're using it to enforce lock
ordering as Oliver suggests, then there are probably more robust
solutions.

Thanks,
Jesse
