Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTJFQk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTJFQk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:40:57 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:8577 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262193AbTJFQk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:40:56 -0400
Date: Mon, 6 Oct 2003 17:41:23 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310061641.h96GfNQ4001095@81-2-122-30.bradfords.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Dave Jones <davej@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0310061218040.9590@chaos>
References: <Pine.LNX.4.53.0310031322430.499@chaos>
 <20031003235801.GA5183@redhat.com>
 <Pine.LNX.4.53.0310060834180.8593@chaos>
 <16257.26407.439415.325123@gargle.gargle.HOWL>
 <Pine.LNX.4.53.0310061218040.9590@chaos>
Subject: Re: FDC motor left on
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well we are in agreement that it must be turned OFF. The only
> question is where it should be done. Already the kernel fixes
> the video board (generic VGA) and other stuff that it may
> find wrong (PCI bus), etc. So, a simple read/write to a
> machine-compatible port might be the simplest accommodation.

Maybe this fix should go in now, and a thorough overview of legacy
workarounds done during the 2.7 development cycle.

Overall, what I'm thinking is that while it's generally a good idea to
keep workarounds for really ancient hardware, just in case somebody
does want to still use it, workarounds for buggy hardware that, for
example, only ever existed on ISA cards, are at best pointless on
systems which don't have any ISA slots, and at worst could cause
problems with future hardware.

John.
