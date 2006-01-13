Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423008AbWAMWSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423008AbWAMWSX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423015AbWAMWSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:18:23 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55022 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1423008AbWAMWSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:18:22 -0500
Subject: Re: Dual core Athlons and unsynced TSCs
From: Sven-Thorsten Dietrich <sven@mvista.com>
To: David Lang <dlang@digitalinsight.com>
Cc: thockin@hockin.org, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0601131404311.9821@qynat.qvtvafvgr.pbz>
References: <1137178855.15108.42.camel@mindpipe>
	 <Pine.LNX.4.62.0601131315310.9821@qynat.qvtvafvgr.pbz>
	 <20060113215609.GA30634@hockin.org>
	 <Pine.LNX.4.62.0601131404311.9821@qynat.qvtvafvgr.pbz>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Date: Fri, 13 Jan 2006 14:18:18 -0800
Message-Id: <1137190698.2536.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 14:05 -0800, David Lang wrote:
> On Fri, 13 Jan 2006 thockin@hockin.org wrote:
> 
> > On Fri, Jan 13, 2006 at 01:18:35PM -0800, David Lang wrote:
> >> Lee, the last time I saw this discussion I thought it was identified that
> >> the multiple cores (or IIRC the multiple chips in a SMP motherboard) would
> >> only get out of sync when power management calls were made (hlt or
> >> switching the c-state). IIRC the workaround that was posted then was to
> >> just disable these in the kernel build.
> >
> > not using 'hlt' when idling means that you spend 10s of Watts more power
> > on mostly idle systems.
> 
> true, but for people who need better time accruacy then the other 
> workaround this may be very acceptable.
> 

1/4 KW / day for time synchronisation. 

The power company would love that.

> David Lang
> 
-- 
***********************************
Sven-Thorsten Dietrich
Real-Time Software Architect
MontaVista Software, Inc.
1237 East Arques Ave.
Sunnyvale, CA 94085

Phone: 408.992.4515
Fax: 408.328.9204

http://www.mvista.com
Platform To Innovate
*********************************** 

