Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264720AbSJ3QLG>; Wed, 30 Oct 2002 11:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264721AbSJ3QLG>; Wed, 30 Oct 2002 11:11:06 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:9171 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264720AbSJ3QLF>;
	Wed, 30 Oct 2002 11:11:05 -0500
Date: Wed, 30 Oct 2002 16:17:08 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: boissiere@adiglobal.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [STATUS 2.5]  October 30, 2002
Message-ID: <20021030161708.GA8321@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	boissiere@adiglobal.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o in 2.5.35  Serial ATA support  (Andre Hedrick)

Erm, really ? 

> o Post-freeze  Add hardware sensors drivers  (lm_sensors team)

Something else I took a look at in the last few days was the ECC
drivers. These are also zero impact, and could go in after the freeze
(assuming the authors want them merged). They could do with a small
amount of cleanup, but otherwise look ok.

> o Started  Reorder x86 initialization  (Dave Jones, Randy Dunlap)

I've jiggled a bunch of this (Randy didnt have time to play here)
around as much as its probably going to be for 2.6. It's in -dj,
has been sent for -ac, and will likely go to Linus post-freeze
as its all cleanups, and one-liners.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
