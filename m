Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVAOC1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVAOC1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVAOC1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:27:10 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:40378 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262150AbVAOC1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:27:07 -0500
Date: Sat, 15 Jan 2005 03:26:56 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Barry K. Nathan" <barryn@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: swapspace layout improvements advocacy
In-Reply-To: <20050114225213.GA4841@ip68-4-98-123.oc.oc.cox.net>
Message-ID: <Pine.LNX.4.53.0501150320130.24136@gockel.physik3.uni-rostock.de>
References: <20050112123524.GA12843@lnx-holt.americas.sgi.com>
 <Pine.LNX.4.44.0501121758180.2765-100000@localhost.localdomain>
 <20050112105315.2ac21173.akpm@osdl.org> <Pine.LNX.4.53.0501141433000.7044@gockel.physik3.uni-rostock.de>
 <20050114225213.GA4841@ip68-4-98-123.oc.oc.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, Barry K. Nathan wrote:

> I haven't tried the patch in question (unless it's in any Fedora
> kernels), but I've noticed that the single biggest step to improve
> swapping performance in 2.6 is to use the CFQ scheduler, not the AS
> scheduler. (That's also why Red Hat/Fedora kernels use CFQ as the
> default scheduler.)

Yes, I also use CFQ. Didn't dare to try with the anticipatory scheduler.

Since Andrew was so sceptical, I tested a bit more, and it's not as easily 
reproducible as I wrote. There don't seem to be any problems on a freshly 
booted system. It only happens after using the system for some time. But I 
think that's only natural as the virtal->physical mapping needs to be 
disturbed before seeing any problems.

Tim
