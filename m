Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWBWDBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWBWDBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 22:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWBWDBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 22:01:47 -0500
Received: from mxsf34.cluster1.charter.net ([209.225.28.159]:24789 "EHLO
	mxsf34.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750718AbWBWDBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 22:01:46 -0500
X-IronPort-AV: i="4.02,138,1139202000"; 
   d="scan'208"; a="1865798911:sNHT130530942"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17405.9618.444702.719366@smtp.charter.net>
Date: Wed, 22 Feb 2006 22:01:38 -0500
From: "John Stoffel" <john@stoffel.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, David Zeuthen <david@fubar.dk>,
       Kay Sievers <kay.sievers@suse.de>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
In-Reply-To: <20060222180423.GD27946@ftp.linux.org.uk>
References: <1140383653.11403.8.camel@localhost>
	<20060220010205.GB22738@suse.de>
	<1140562261.11278.6.camel@localhost>
	<20060221225718.GA12480@vrfy.org>
	<Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>
	<20060222152743.GA22281@vrfy.org>
	<Pine.LNX.4.64.0602220737170.30245@g5.osdl.org>
	<1140625103.21517.18.camel@daxter.boston.redhat.com>
	<Pine.LNX.4.64.0602220848280.30245@g5.osdl.org>
	<Pine.LNX.4.64.0602220915500.30245@g5.osdl.org>
	<20060222180423.GD27946@ftp.linux.org.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Al" == Al Viro <viro@ftp.linux.org.uk> writes:

Al> The only place where _transport_ enters the picture is that RBC is
Al> very common in e.g. firewire-to-IDE bridges, so sbp2 had to deal
Al> with it somehow.  And instead of teaching sd.c to deal with those
Al> (it's very easy) it went ahead and just marked those as type 0
Al> (disk).  Almost worked...

I wonder if this change will fix all the problems I've had trying to
make my prolific chipset (crap) Firewire/USB enclosure to actually
work when used with firewire?  It's finally stable with USB, but
obviously not the best performance.

Gotta try this again sometime.

John
