Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVGKN03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVGKN03 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVGKN02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:26:28 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:29901 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261623AbVGKN01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:26:27 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       azarah@nosferatu.za.org, cw@f00f.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <1120936561.6488.84.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <1120933916.3176.57.camel@laptopd505.fenrus.org>
	 <1120934163.6488.72.camel@mindpipe> <20050709121212.7539a048.akpm@osdl.org>
	 <1120936561.6488.84.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121088186.7407.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Jul 2005 14:23:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Because some machines exhibit appreciable latency in entering low power
> > state via ACPI, and 1000Hz reduces their battery life.  By about half,
> > iirc.
> > 
> Then the owners of such machines can use HZ=250 and leave the default
> alone.  Why should everyone have to bear the cost?

They need 100 really it seems, 250-500 have no real effect and on the
Dell I tried 250 didn't stop the wild clock slew from the APM bios
either. I played with this a fair bit on a couple of laptops. I've not
seen anything > 20% saving however so I've no idea who/why someone saw
50%
