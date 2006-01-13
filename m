Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbWAMLiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWAMLiJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 06:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161180AbWAMLiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 06:38:08 -0500
Received: from mtaout3.012.net.il ([84.95.2.7]:16436 "EHLO mtaout3.012.net.il")
	by vger.kernel.org with ESMTP id S1161158AbWAMLiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 06:38:06 -0500
Date: Fri, 13 Jan 2006 13:37:56 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
In-reply-to: <1137105731.2370.94.camel@mindpipe>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adrian Bunk <bunk@stusta.de>, Jon Mason <jdmason@us.ibm.com>,
       Jiri Slaby <slaby@liberouter.org>, linux-kernel@vger.kernel.org
Message-id: <20060113113756.GL5399@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060112175051.GA17539@us.ibm.com>
 <43C6ADDE.5060904@liberouter.org> <20060112200735.GD5399@granada.merseine.nu>
 <20060112214719.GE17539@us.ibm.com> <20060112220039.GX29663@stusta.de>
 <1137105731.2370.94.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 05:42:10PM -0500, Lee Revell wrote:
> On Thu, 2006-01-12 at 23:00 +0100, Adrian Bunk wrote:
> > CYBER5050 is discussed in ALSA bug #1293 (tester wanted).
> 
> OK I set that bug to FEEDBACK, but it's open 5 months now and no testers
> are forthcoming.  I think if we don't find one as a result of this
> thread we can assume no one cares about this hardware anymore.
> 
> I'm still not sure that just adding it to the ALSA driver and hoping it
> works is the best solution.  Would we rather users see right away that
> their hardware isn't supported, or have the driver load and get no sound
> or hang the machine?

... or use the known working OSS driver?

> I think the best approach might just be to drop it in lieu of a tester.
> It will be trivial to add support later if someone finds one of these
> boxes.

So you advocate removing a known working driver in favor of a known
not to be working driver? nice.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

