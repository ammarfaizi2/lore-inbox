Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268069AbTBMP7e>; Thu, 13 Feb 2003 10:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268074AbTBMP7e>; Thu, 13 Feb 2003 10:59:34 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:45723 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268069AbTBMP7c>;
	Thu, 13 Feb 2003 10:59:32 -0500
Date: Thu, 13 Feb 2003 16:04:30 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: wingel@nano-systems.com, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
Message-ID: <20030213160430.GC2070@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Rusty Lynch <rusty@linux.co.intel.com>, wingel@nano-systems.com,
	lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1045106216.1089.16.camel@vmhack> <20030213115545.GA26814@codemonkey.org.uk> <1045150488.1009.3.camel@vmhack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045150488.1009.3.camel@vmhack>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 07:34:35AM -0800, Rusty Lynch wrote:

 > The watchdogN devices show up under the "legacy" directory because
 > they are platform devices.  From reading the driver-model documentation,
 > I believe that platform devices are the correct way of categorizing
 > watchdog devices.

My interpretation of legacy devices differs. I believe they are
onboard devices that we've had since just after the dinosaurs died.
FDC controller, dma controller, parport etc..

A plugin watchdog card doesn't fit this description.

		Dave 

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
