Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVACNYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVACNYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVACNY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:24:29 -0500
Received: from smtp.terra.es ([213.4.129.129]:60733 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S261437AbVACNYT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:24:19 -0500
Date: Mon, 3 Jan 2005 14:24:12 +0100
From: Diego Calleja <diegocg@teleline.es>
To: Willy Tarreau <willy@w.ods.org>
Cc: wli@holomorphy.com, bunk@stusta.de, davidsen@tmr.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-Id: <20050103142412.490239b8.diegocg@teleline.es>
In-Reply-To: <20050103053304.GA7048@alpha.home.local>
References: <20050102221534.GG4183@stusta.de>
	<41D87A64.1070207@tmr.com>
	<20050103003011.GP29332@holomorphy.com>
	<20050103004551.GK4183@stusta.de>
	<20050103011935.GQ29332@holomorphy.com>
	<20050103053304.GA7048@alpha.home.local>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 3 Jan 2005 06:33:04 +0100 Willy Tarreau <willy@w.ods.org> escribió:

> I clearly don't agree with you, for a simple reason : those out-of-tree
> features will always be, because each distro likes to add a few features,
> like SquashFS, PaX, etc... And indeed, that's one of the reasons I *stay*
> on 2.4. It's so simple to simply upgrade the kernel, patch and recompile
> without spending days complaining "grrr... why did they change this ?".


2.6 will stop having small issues in each release until 2.7 is forked just
like 2.4 broke things until 2.5 was forked. The difference IMO
is that linux development now avoids things like the unstability which the
2.4.10 changes caused and things like the fs corruption bugs we saw in 2.4

I fully agree with WLI that the 2.4 development model and the
backporting-mania created more problems than it solved, because in the real
world almost everybody uses what distros ship, and what distros ship isn't
kernel.org but heavily modified kernels, which means that the kernel.org
was not really "well-tested" or it took much longer to become "well-tested"
because it wasn't really being used.

