Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbTINO7W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 10:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbTINO7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 10:59:22 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:22431 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261171AbTINO7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 10:59:21 -0400
Subject: Re: [2.6 patch] add a config option for -Os compilation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wade <neroz@ii.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F6472F4.8080509@ii.net>
References: <20030914121655.GS27368@fs.tum.de>  <3F6472F4.8080509@ii.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063551468.14837.5.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sun, 14 Sep 2003 15:57:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-14 at 14:53, Wade wrote:
> Adrian Bunk wrote:
> > The patch below adds a config option OPTIMIZE_FOR_SIZE for telling gcc 
> > to use -Os instead of -O2. Besides this, it removes constructs on 
> > architectures that had a -Os hardcoded in their Makefiles.
> 
> Someone told me that -Os is actually faster than -O2 for Athlons, is 
> that true?

On gcc 2.95 -Os was faster for most stuff. I would intuitively expect
the best result to be a mix varied by function but I don't think gcc has
the support to do that.

I've also not benched gcc 3.2 -Os v -O2 at real workloads - thats a 
nice little project for someone.

