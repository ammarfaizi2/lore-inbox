Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTKGWV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTKGWV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:21:26 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35084 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264365AbTKGObm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 09:31:42 -0500
Date: Fri, 7 Nov 2003 09:21:00 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rob Landley <rob@landley.net>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <200311070313.53958.rob@landley.net>
Message-ID: <Pine.LNX.3.96.1031107091607.20991C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Nov 2003, Rob Landley wrote:

> Note this still doesn't mean you can scroll large X windows for two or three 
> seconds at a time without burning a coaster.
> 
> I had high hopes with the new scheduler, but no.  (Maybe if I niced the heck 
> out of cdrecord...)

Wow, is the new scheduler that broken? cdrecord run as a realtime process
and should definitely keep going pretty much in spite of what you do. It's
realtime priority and locked in core IIRC. The only problem I've had is
running out of data burning from NFS mounted data, if I get a load of SPAM
the network gets slow. My fault for not spending the time to copy the data
twice or buy a burnfree device.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

