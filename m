Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVICEFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVICEFH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 00:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVICEFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 00:05:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61312 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750963AbVICEFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 00:05:06 -0400
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick
	calculation in timer_pm.c
From: Lee Revell <rlrevell@joe-job.com>
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, s0348365@sms.ed.ac.uk,
       kernel@kolivas.org, tytso@mit.edu, cfriesen@nortel.com, trenn@suse.de,
       george@mvista.com, johnstul@us.ibm.com, akpm@osdl.org
In-Reply-To: <20050831171211.GB4974@in.ibm.com>
References: <20050831165843.GA4974@in.ibm.com>
	 <20050831171211.GB4974@in.ibm.com>
Content-Type: text/plain
Date: Sat, 03 Sep 2005 00:05:00 -0400
Message-Id: <1125720301.4991.41.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-31 at 22:42 +0530, Srivatsa Vaddagiri wrote:
> With this patch, time had kept up really well on one particular
> machine (Intel 4way Pentium 3 box) overnight, while
> on another newer machine (Intel 4way Xeon with HT) it didnt do so
> well (time sped up after 3 or 4 hours). Hence I consider this
> particular patch will need more review/work.
> 

Are lost ticks really that common?  If so, any idea what's disabling
interrupts for so long (or if it's a hardware issue)?  And if not, it
seems like you'd need an artificial way to simulate lost ticks in order
to test this stuff.

Lee

