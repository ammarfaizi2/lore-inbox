Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVEMT5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVEMT5m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVEMTxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:53:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56239 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262521AbVEMTwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:52:01 -0400
Date: Fri, 13 May 2005 21:52:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Alexander Nyberg <alexn@telia.com>, Jan Beulich <JBeulich@novell.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] adjust x86-64 watchdog tick calculation
Message-ID: <20050513195215.GC3135@elf.ucw.cz>
References: <s2832159.057@emea1-mh.id2.novell.com> <1115892008.918.7.camel@localhost.localdomain> <20050512142920.GA7079@openzaurus.ucw.cz> <20050513113023.GD15755@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050513113023.GD15755@wotan.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 13-05-05 13:30:23, Andi Kleen wrote:
> > Because it kills machine when interrupt latency gets too high?
> > Like reading battery status using i2c...
> 
> That's a bug in the I2C reader then. Don't shot the messenger for bad news.

Disagreed.

Linux is not real time OS. Perhaps some real-time constraints "may not
spend > 100msec with interrupts disabled" would be healthy, but it
certainly needs more discussion than "lets enable NMI
watchdog.". It needs to be written somewhere in big bold letters, too.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
