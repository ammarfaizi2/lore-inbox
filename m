Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275517AbTHMUho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275518AbTHMUhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:37:43 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41991 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S275517AbTHMUhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:37:43 -0400
Date: Wed, 13 Aug 2003 16:16:23 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David D. Hagood" <wowbagger@sktc.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: time for some drivers to be removed?
In-Reply-To: <20030729193309.GQ28767@fs.tum.de>
Message-ID: <Pine.LNX.3.96.1030813161442.12417B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Adrian Bunk wrote:

> > Interesting question - whatever I guess. We don't have an existing convention.
> > How many drivers have we got nowdays that failing on just SMP ?
> 
> I 2.6.0-test2 tested on i386 with a .config that is without support for
> modules and compiles as much as possible statically into the kernel.
> Without claiming completeness, I found this way besides the complete Old
> ISDN4Linux subsystem 36 drivers that compile due to cli/sti issues only
> on UP.

Should those be made to depend on SMP (not SMP) perhaps? They are probably
high candidates for fixing if they work UP.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

