Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUI2Ay4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUI2Ay4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 20:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268126AbUI2Awt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 20:52:49 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:11145 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268127AbUI2Avb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 20:51:31 -0400
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jonathan@jonmasters.org
Cc: Lars Marowsky-Bree <lmb@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Thomas Habets <thomas@habets.pp.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <35fb2e590409270612524c5fb9@mail.gmail.com>
References: <200409230123.30858.thomas@habets.pp.se>
	 <20040923234520.GA7303@pclin040.win.tue.nl>
	 <1096031971.9791.26.camel@localhost.localdomain>
	 <200409242158.40054.thomas@habets.pp.se>
	 <1096060549.10797.10.camel@localhost.localdomain>
	 <20040927104120.GA30364@logos.cnet>
	 <20040927125441.GG3934@marowsky-bree.de>
	 <35fb2e590409270612524c5fb9@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096288597.9911.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Sep 2004 13:36:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-27 at 14:12, Jon Masters wrote:
> What would be wrong with having the page reclaim algorithms use one of
> the low memory watermarks as a trigger to call in to userspace to
> extend the swap available if possible? This is probably what Microsoft
> et al do with their "Windows is extending your virtual memory, yada
> yada blah blah". Comments? Already done?

Seems a reasonable use for a hotplug or netlink event for 2.6, send
patches...

