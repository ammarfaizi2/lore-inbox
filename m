Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbTF3WHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265925AbTF3WHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:07:21 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17422 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265922AbTF3WHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:07:19 -0400
Date: Mon, 30 Jun 2003 18:14:19 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.73-mjb2
In-Reply-To: <20030628143343.GX26348@holomorphy.com>
Message-ID: <Pine.LNX.3.96.1030630181047.8022B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jun 2003, William Lee Irwin III wrote:

> At some point in the past, Szonyi Calin <sony@etc.utt.ro> wrote:
> >> I tested 2.5.72-mjb2 but it was full of oopses and crashes on my Duron
> >> so I thought this patch is only for NUMA stuff.
> 
> On Sat, Jun 28, 2003 at 07:10:26AM -0700, Martin J. Bligh wrote:
> > Nope, it should work with any machine  - you got the oopses?
> > If you have an old distro with glibc < 2.3.1, Bill thinks the upside_down
> > trick doesn't work because of some invalid assumptions glibc is making.
> > If that's the case, could you check that 2.5.73-mjb1 works OK?
> 
> If this is causing too much confusion and/or other anguish I can live
> with it getting withdrawn and keep it rolling in the ultra-experimental
> section (-wli).
> 
> Alternatively, it should be trivial to convert to a config option that's
> off by default.

Haven't had a chance to try this yet, so I don't have a feel for the
benefit (other than good karma). But having as an option is good,
depending on how out of date the lib has to be to have troubles should
determine default, this is not the stock kernel and can be defaulted to
enable new features IMHO.

The reason I haven't tried it is because I'm trying to find time to shake
out the 73-wli kernel, which will find a home on my slower boxen.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

