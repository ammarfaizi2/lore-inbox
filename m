Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVEMVeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVEMVeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVEMVaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:30:39 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:46247 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262503AbVEMV16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:27:58 -0400
Subject: Re: [discuss] Re: [PATCH] adjust x86-64 watchdog tick calculation
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, Alexander Nyberg <alexn@telia.com>,
       Jan Beulich <JBeulich@novell.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050513195215.GC3135@elf.ucw.cz>
References: <s2832159.057@emea1-mh.id2.novell.com>
	 <1115892008.918.7.camel@localhost.localdomain>
	 <20050512142920.GA7079@openzaurus.ucw.cz>
	 <20050513113023.GD15755@wotan.suse.de>  <20050513195215.GC3135@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 13 May 2005 17:27:56 -0400
Message-Id: <1116019676.6380.37.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 21:52 +0200, Pavel Machek wrote:
> On Pá 13-05-05 13:30:23, Andi Kleen wrote:
> > > Because it kills machine when interrupt latency gets too high?
> > > Like reading battery status using i2c...
> > 
> > That's a bug in the I2C reader then. Don't shot the messenger for bad news.
> 
> Disagreed.
> 
> Linux is not real time OS. Perhaps some real-time constraints "may not
> spend > 100msec with interrupts disabled" would be healthy
             ^^^^
You mean "microseconds", right?  100ms will be perceived by the user as,
well, their machine freezing for 100ms...

Lee

