Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268565AbTCAPXl>; Sat, 1 Mar 2003 10:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268592AbTCAPXl>; Sat, 1 Mar 2003 10:23:41 -0500
Received: from adsl-66-140-130-38.dsl.hstntx.swbell.net ([66.140.130.38]:24009
	"EHLO adsl-66-140-130-116.dsl.hstntx.swbell.net") by vger.kernel.org
	with ESMTP id <S268565AbTCAPXk>; Sat, 1 Mar 2003 10:23:40 -0500
Date: Sat, 1 Mar 2003 09:33:32 -0600
From: redelm@ev1.net
To: John Bradford <john@grabjohn.com>
Cc: wyleus <coyote1@cytanet.com.cy>, redelm@ev1.net,
       linux-kernel@vger.kernel.org, vga@port.imtp.ilyichevsk.odessa.ua
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
Message-ID: <20030301153332.GA16024@adsl-66-140-130-38.dsl.hstntx.swbell.net>
References: <20030301082126.56c00418.coyote1@cytanet.com.cy> <200303011455.h21EtwhU000402@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303011455.h21EtwhU000402@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 02:55:58PM +0000, John Bradford wrote:
> /dev/hda2	/	ext3	defaults, noatime	1  1
                                         ^

No space.  At times Unix is just as fussy as IBM JCL :)   
Agreed on the value of `noatime`.  It made a huge difference 
in responsiveness on an old 486sx25 laptop.

> I seriously doubt that a single RAM module should be installed in the
> middle slot of three.  One of the end slotf would seem more likely.

Agreed.  But on some mobos, it doesn't matter.  Then I prefer the
furthest slot from the RAM controller.  Sure, signal time-of-flight
is a few ps longer, but at least the bus is terminated and will
have fewer reflections.

> It might have been disconnecting and reconnecting the RAM that
> improved things, not the change of slot.  Try both end slots.

Yes.  Reseating will creat new electrical connections.

-- Robert   author `cpuburn`  http://users.ev1.net/~redelm

