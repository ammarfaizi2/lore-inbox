Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269725AbUICS37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269725AbUICS37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269729AbUICS3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:29:38 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40321 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269725AbUICS2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:28:23 -0400
Subject: Re: lockup with voluntary preempt R0 and VP, KP, etc, disabled
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
In-Reply-To: <20040903140811.37ae8067@mango.fruits.de>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040903100946.GA22819@elte.hu> <20040903123139.565c806b@mango.fruits.de>
	 <20040903103244.GB23726@elte.hu> <20040903135919.719db41d@mango.fruits.de>
	 <20040903140425.26fddf8e@mango.fruits.de>
	 <20040903140811.37ae8067@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1094236105.6575.16.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 14:28:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 08:08, Florian Schmidt wrote:
> On Fri, 3 Sep 2004 14:04:25 +0200
> Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > 
> > and for completeness sake here's my kernel .config:
> > 
> [snip]
> 
> btw: how can i set a different kernel "name" so the modules get their
> own subdir in /lib/? 
> 

Change EXTRAVERSION in the top level kernel Makefile.  The newer VP
patches do this for you.

Lee

