Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268025AbTBMLvG>; Thu, 13 Feb 2003 06:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268026AbTBMLvG>; Thu, 13 Feb 2003 06:51:06 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:24473 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268025AbTBMLvG>;
	Thu, 13 Feb 2003 06:51:06 -0500
Date: Thu, 13 Feb 2003 11:55:45 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: wingel@nano-systems.com, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
Message-ID: <20030213115545.GA26814@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Rusty Lynch <rusty@linux.co.intel.com>, wingel@nano-systems.com,
	lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1045106216.1089.16.camel@vmhack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045106216.1089.16.camel@vmhack>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 07:16:55PM -0800, Rusty Lynch wrote:
 > Basically, with the help of some watchdog infrastructure code, we could make 
 > each watchdog device register as a platform_device named watchdog, so for 
 > every watchdog on the system there is a /sys/devices/legacy/watchdogN/ 
 > directory created for it.  

Why legacy ? That seems an odd place to be putting these.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
