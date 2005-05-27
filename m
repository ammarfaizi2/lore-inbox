Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVE0PdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVE0PdB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 11:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVE0PdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 11:33:01 -0400
Received: from mout.perfora.net ([217.160.230.41]:31192 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S261837AbVE0PcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 11:32:12 -0400
Subject: Re: Tyan Opteron boards and problems with parallel ports (badpmd)
From: Christopher Warner <chris@servertogo.com>
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
Cc: Christopher Warner <cwarner@kernelcode.com>,
       "Peter J. Stieber" <developer@toyon.com>, linux-kernel@vger.kernel.org,
       Bill Davidsen <davidsen@tmr.com>
In-Reply-To: <Pine.LNX.4.62.0505262112540.32548@twin.uoregon.edu>
References: <3174569B9743D511922F00A0C943142309F815A6@TYANWEB>
	 <037801c5616a$b1be6600$1600a8c0@toyon.corp> <4295E9F1.6080304@tmr.com>
	 <022e01c56233$241e5930$1600a8c0@toyon.corp>
	 <1117156446.8874.41.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0505262112540.32548@twin.uoregon.edu>
Content-Type: text/plain
Date: Fri, 27 May 2005 06:49:24 -0400
Message-Id: <1117190965.13932.36.camel@sabrina>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: perfora.net abuse@perfora.net login:d2cbd72fb1ab4860f78cabc62f71ec31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 21:41 -0700, Joel Jaeggli wrote:
> On Thu, 26 May 2005, Christopher Warner wrote:
> 
> > Just read the other existing thread linked. Is everyone running the same
> > model opteron on these Tyan boards (246)? To update even further.
> > Besides the parallel port problem I've sent back about 5 of these tyan
> > motherboards. A couple of then simply didn't have the gigabit network
> > adapters available via bios. In some cases linux loaded the drivers for
> > the adapters regardless of their setting in BIOS. In other cases they
> > simply were not available.
> 
> I have 4 tyan s2882's. 2 with 244's and 2GB of ram and 2 with 246 and 4GB 
> of ram. I don't appear to have bad parallel ports or bad ethernet 
> interfaces. They're running fedora core 3's 2.6.11 x86_64 kernel
> (2.6.11-1.14_FC3smp)... I cna't tell you what bios version off the top of 
> my head but i can reboot one tomorrow if that helps.

Not to interested in the BIOS versions anymore. As the tyan boards in
question have been rma'd I'm not exactly sure whats going on with them
now. The tyan boards I have in here right now appear to work properly
except for the pmd issue, i've noticed nothing wrong with them besides
that. 

What we need is to try and single out the variables that are causing the
badpmd's. Also the more people who report badpmd's with Andi Kleen's
intial patch the better. Especially on different archs; would also be
good. So far from lkml i'm only seeing Tyan S28* boards as of recent.

-Christopher Warner

