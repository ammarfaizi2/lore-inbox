Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWHUCaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWHUCaY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 22:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWHUCaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 22:30:24 -0400
Received: from smtp-relay.dca.net ([216.158.48.66]:28383 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S1751805AbWHUCaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 22:30:23 -0400
Date: Sun, 20 Aug 2006 22:30:17 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Frodo Looijaard <frodol@dds.nl>,
       Philip Edelbrock <phil@netroedge.com>,
       Mark Studebaker <mdsxyz123@yahoo.com>, lm-sensors@lm-sensors.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error handling
Message-ID: <20060821023017.GA30017@jupiter.solarsys.private>
References: <44E8C9AE.3060307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E8C9AE.3060307@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Michal:

* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> [2006-08-20 22:44:30 +0200]:
> This patch fixes 56 sparse "ignoring return value of 'device_create_file'" warnings. It also adds error handling.
> 
> w83627hf.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 80 insertions(+), 16 deletions(-)

Thanks for doing this... but Andrew please don't apply it.  The sensors project
people are working on these even now, and we already have a patch for the
w83627hf driver...

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017204.html

Jean Delvare (hwmon maintainer) should be sending these up the chain soon.

Michal: if you're interested in fixing any of the rest of them, please take
a look at the patch above to see the mechanism we intend to use.  It actually
makes the drivers *smaller* than they were.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

