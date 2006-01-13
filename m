Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423009AbWAMWNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423009AbWAMWNz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423010AbWAMWNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:13:55 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:1252 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1423009AbWAMWNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:13:54 -0500
Date: Fri, 13 Jan 2006 14:23:49 -0800
From: thockin@hockin.org
To: David Lang <dlang@digitalinsight.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
Message-ID: <20060113222349.GA32363@hockin.org>
References: <1137178855.15108.42.camel@mindpipe> <Pine.LNX.4.62.0601131315310.9821@qynat.qvtvafvgr.pbz> <20060113215609.GA30634@hockin.org> <Pine.LNX.4.62.0601131404311.9821@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601131404311.9821@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 02:05:23PM -0800, David Lang wrote:
> On Fri, 13 Jan 2006 thockin@hockin.org wrote:
> 
> >On Fri, Jan 13, 2006 at 01:18:35PM -0800, David Lang wrote:
> >>Lee, the last time I saw this discussion I thought it was identified that
> >>the multiple cores (or IIRC the multiple chips in a SMP motherboard) would
> >>only get out of sync when power management calls were made (hlt or
> >>switching the c-state). IIRC the workaround that was posted then was to
> >>just disable these in the kernel build.
> >
> >not using 'hlt' when idling means that you spend 10s of Watts more power
> >on mostly idle systems.
> 
> true, but for people who need better time accruacy then the other 
> workaround this may be very acceptable.

sure, if power doesn't matter use idle=poll => problem solved.
