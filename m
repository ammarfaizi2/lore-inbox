Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161127AbVICEeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbVICEeb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 00:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbVICEeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 00:34:31 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:34179 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161127AbVICEeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 00:34:31 -0400
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost
	tick	calculation in timer_pm.c
From: Lee Revell <rlrevell@joe-job.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, arjan@infradead.org,
       s0348365@sms.ed.ac.uk, kernel@kolivas.org, tytso@mit.edu,
       cfriesen@nortel.com, trenn@suse.de, george@mvista.com,
       johnstul@us.ibm.com, akpm@osdl.org
In-Reply-To: <43192423.2040400@bigpond.net.au>
References: <20050831165843.GA4974@in.ibm.com>
	 <20050831171211.GB4974@in.ibm.com> <1125720301.4991.41.camel@mindpipe>
	 <43192423.2040400@bigpond.net.au>
Content-Type: text/plain
Date: Sat, 03 Sep 2005 00:34:28 -0400
Message-Id: <1125722069.4991.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-03 at 14:18 +1000, Peter Williams wrote:
> In my experience, turning off DMA for IDE disks is a pretty good way to 
> generate lost ticks :-)

For this to "work" you have to unset "unmask IRQ" with hdparm, right?

Lee

