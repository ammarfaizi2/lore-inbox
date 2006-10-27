Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423685AbWJ0FhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423685AbWJ0FhQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 01:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423692AbWJ0FhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 01:37:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:12172 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423685AbWJ0FhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 01:37:10 -0400
X-Authenticated: #14349625
Subject: Re: [2.6.18-rt7] BUG: time warp detected!
From: Mike Galbraith <efault@gmx.de>
To: john stultz <johnstul@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1161927940.6039.6.camel@Homer.simpson.net>
References: <1161847210.32585.14.camel@Homer.simpson.net>
	 <1161897932.960.49.camel@localhost>
	 <1161927940.6039.6.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 06:08:41 +0000
Message-Id: <1161929321.6102.2.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 05:45 +0000, Mike Galbraith wrote:
> On Thu, 2006-10-26 at 14:25 -0700, john stultz wrote:
> > On Thu, 2006-10-26 at 07:20 +0000, Mike Galbraith wrote:
> > > $subject happened on my single P4/HT box sometime after resume from
> > > disk.  Hohum activity:  I had just read lkml and was retrieving latest
> > > glibc snapshot when I noticed the trace.  I also noticed that the kernel
> > > decided to use pit instead of tsc.
> > 
> > Huh. Was the PIT selected before or after the resume from disk?
> 
> Both.  If I don't specify tsc, it chooses pit.  I just removed freshly
> added clocksource=tsc, rebooted, and I'm back on pit again.

(hm. virgin 2.6.18 selects tsc properly... will rummage through rt7)

