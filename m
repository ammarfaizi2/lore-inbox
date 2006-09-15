Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWIOJRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWIOJRd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 05:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWIOJRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 05:17:32 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:15347 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750774AbWIOJRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 05:17:32 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 7.0.1 July 07, 2006
Message-ID: <OFA90286D9.9C068080-ON802571EA.00322217-802571EA.00330817@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Fri, 15 Sep 2006 10:17:24 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 15/09/2006 10:19:41
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:

> > I don't think anyone is saying that static tracepoints do not have
> > their limitations, or that dynamic tracepointing is useless. But
> > that's not the point ... why can't we have one infrastructure that
> > supports both? Preferably in a fairly simple, consistent way.
>
> primarily because i fail to see any property of static tracers that are
> not met by dynamic tracers. So to me dynamic tracers like SystemTap are
> a superset of static tracers.

There is one example whethere dynamic tracing is difficult or very messy to
implement and that's for tracepoints needed during system and device
initialization. In this sense dynamic is not a practical superset of
static. However I believe the tooling, for dynamic trace should work for
static as well.

- -
Richard J Moore
IBM Advanced Linux Response Team - Linux Technology Centre
MOBEX: 264807; Mobile (+44) (0)7739-875237
Office: (+44) (0)1962-817072

