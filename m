Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTEWIrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTEWIrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:47:36 -0400
Received: from ip68-4-255-84.oc.oc.cox.net ([68.4.255.84]:1408 "EHLO
	ip68-101-124-193.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id S263949AbTEWIrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:47:35 -0400
Date: Fri, 23 May 2003 02:00:40 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.[45] ioperm fix seems broken (was Re: Linux 2.4.21-rc3)
Message-ID: <20030523090040.GA2438@ip68-101-124-193.oc.oc.cox.net>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva> <20030523005149.GA2420@ip68-101-124-193.oc.oc.cox.net> <200305230732.49914.m.c.p@wolk-project.de> <20030523070416.GA2408@ip68-101-124-193.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030523070416.GA2408@ip68-101-124-193.oc.oc.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 12:04:16AM -0700, Barry K. Nathan wrote:
> Nope, the ioperm fix seems to be breaking something alright. Eventually
> I was able to reproduce this on 2.5.69-mm[78] as well.

The reason I "eventually" "reproduced" it on 2.5 is because I
"eventually" ran an old, buggy version of my test case program that I
forgot to delete. :( 2.5 is actually not affected by this bug.

The 2.4 ioperm fix is truly, genuinely buggy, however. I'm going to send
a patch within the next few hours (if not the next few minutes).

-Barry K. Nathan <barryn@pobox.com>
