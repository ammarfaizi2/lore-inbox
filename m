Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263353AbUCPQLZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbUCPQKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:10:07 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:20235 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262008AbUCPQIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:08:04 -0500
Date: Mon, 15 Mar 2004 23:20:46 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, jbarnes@sgi.com, axboe@suse.de
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040316072046.GA636090@sgi.com>
References: <20040316052256.GA647970@sgi.com> <4056A062.6040203@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4056A062.6040203@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 05:36:18PM +1100, Nick Piggin wrote:
> 
> 
> Jeremy Higdon wrote:
> 
> >My tests were on an 8 CPU x 1300 MHz Altix with 64 disks.
> >
> >
> 
> Nice - so if you had enough IO capacity to saturate the CPUs it
> might come close to a 4x improvement - and this sounds like one
> of your baby systems?

Baby by cpu count, mid size by I/O capability.  Extrapolations of
this sort are fraught with peril.  However, it is conceivable that
we would end up with 4X the IOPS.

> I wonder why nobody's complained about this before?

Well, some of us have, but probably not very loudly.  I had
naively believed that the global unplug was gone in 2.6.

jeremy
