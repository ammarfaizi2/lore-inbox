Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752554AbWKAXVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbWKAXVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752555AbWKAXVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:21:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2006 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752554AbWKAXVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:21:24 -0500
Date: Wed, 1 Nov 2006 15:21:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: Remove hotplug cpu crap from cpufreq.
In-Reply-To: <200611020009.17711.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.64.0611011512450.25218@g5.osdl.org>
References: <20061101225925.GA17363@redhat.com> <200611020009.17711.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Nov 2006, Rafael J. Wysocki wrote:
> 
> Won't there be any problems with suspend on SMP vs cpufreq if this stuff is
> removed?

Well, at least traditionally, the hotplug locking has caused more problems 
than it has fixed, but at least right _now_ it seems to work.

At least for the one machine I tend to test on (Core Duo Mac Mini) a 
suspend currently works at least once (which is not saying a lot, 
especially as the X server I use right now is broken and doesn't bring the 
screen back. Oh, well).

			Linus
