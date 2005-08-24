Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbVHXGfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbVHXGfk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 02:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbVHXGfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 02:35:39 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:26758 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1751473AbVHXGfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 02:35:39 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Roman Zippel <zippel@linux-m68k.org>
Date: Wed, 24 Aug 2005 08:34:53 +0200
MIME-Version: 1.0
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       George Anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Message-ID: <430C312D.21770.54E50A3@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.61.0508240134050.3743@scrub.home>
References: <1124838847.20617.11.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.26/Sophos-P=3.95.0+V=3.95+U=2.07.102+R=04 July 2005+T=107749@20050824.062552Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Aug 2005 at 1:54, Roman Zippel wrote:

[...]
> error) >> shift". The difference between system time and reference 
> time is really important. gettimeofday() returns the system time, NTP 
> controls the reference time and these two are synchronized regularly.
[...]

Roman,

I'm having a problem with your wording: NTP _does_ control the "system time" 
(system clock), because it's the only clock it can use. The "reference time" is 
usually remote or elsewhere (multiple sources). Local NTP does not control the 
remote reference time(s).

Regards,
Ulrich

