Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTEIMuv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbTEIMuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:50:51 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33553 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263023AbTEIMut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:50:49 -0400
Date: Fri, 9 May 2003 08:57:48 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "David S. Miller" <davem@redhat.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
In-Reply-To: <1052304024.9817.3.camel@rth.ninka.net>
Message-ID: <Pine.LNX.3.96.1030509085607.26434U-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 May 2003, David S. Miller wrote:

> On Wed, 2003-05-07 at 03:10, Helge Hafting wrote:
> > 2.5.69-mm1 is fine, 2.5.69-mm2 panics after a while even under very
> > light load.
> 
> Do you have AF_UNIX built modular?
> 

This may be the same thing reported in
<20030505144808.GA18518@butterfly.hjsoft.com> earlier, it seems to happen
in 2.5.69 base. Interesting that he has it working in mm1, perhaps the
module just didn't get loaded.

Of course it could be another problem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

