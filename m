Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265889AbTFSShd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 14:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265891AbTFSShd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 14:37:33 -0400
Received: from adsl-157-201-192.dab.bellsouth.net ([66.157.201.192]:33965 "EHLO
	midgaard.us") by vger.kernel.org with ESMTP id S265889AbTFSShb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 14:37:31 -0400
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers  needed
From: Andreas Boman <aboman@midgaard.us>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.0.9.2.20030619184906.00cea3c0@pop.gmx.net>
References: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net>
	 <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net>
	 <5.2.0.9.2.20030619184906.00cea3c0@pop.gmx.net>
Content-Type: text/plain
Message-Id: <1056048717.810.90.camel@asgaard.midgaard.us>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 19 Jun 2003 14:51:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-19 at 13:31, Mike Galbraith wrote:
> At 02:02 AM 6/20/2003 +1000, Con Kolivas wrote:
> >On Fri, 20 Jun 2003 01:47, Mike Galbraith wrote:
> > > At 12:05 AM 6/20/2003 +1000, Con Kolivas wrote:
> > > >Testers required. A version for -ck will be created soon.
> > >
> > > That idea definitely needs some refinement.
> >
> >Actually no it needs a bugfix even more than a refinement!
> >
> >The best_sleep_decay should be 60, NOT 60*Hz
> 
> Ok.  Now it acts as you described.
> 
> thud is also now THUD though, and a parallel kernel build goes insane 
> pretty much instantly.  On the bright side, process_load seems to have lost 
> it's ability to crawl up (under X) and starve new processes forever.
> 

Hmm, I'm still able to completely starve xmms by just moving a window
around ontop of evolution or mozilla though (not possible without this
patch).

	Andreas

