Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbTIOBCU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 21:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTIOBCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 21:02:20 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:9859
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262405AbTIOBCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 21:02:19 -0400
Date: Sun, 14 Sep 2003 21:02:17 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: bill davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <bk2um1$flp$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.53.0309142058120.5140@montezuma.fsmlabs.com>
References: <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com> <20030912195606.24e73086.ak@suse.de>
 <bk2um1$flp$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Sep 2003, bill davidsen wrote:

> We just got a start on making Linux smaller to encourage embedded use, I
> don't see adding 300+ bytes of wasted code so people can run
> misconfigured kernels.
> 
> I rather have to patch this in for my Athlon kernels than have people
> who aren't cutting corners trying to avoid building matching kernels
> have to live with the overhead.

Overhead? Really you could save more memory by cleaning up a lot of 
drivers. Andi already said it before, there are better places to be 
looking at.

Also 'patching' for Athlon kernels doesn't cut it for people who need to 
distribute kernels which run on various hardware (such as distros). This 
alone is benefit enough to justify this supposed 'bloat'.
