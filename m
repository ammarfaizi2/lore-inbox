Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVANWx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVANWx1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVANWw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:52:59 -0500
Received: from orb.pobox.com ([207.8.226.5]:37292 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261850AbVANWwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:52:40 -0500
Date: Fri, 14 Jan 2005 14:52:13 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: swapspace layout improvements advocacy
Message-ID: <20050114225213.GA4841@ip68-4-98-123.oc.oc.cox.net>
References: <20050112123524.GA12843@lnx-holt.americas.sgi.com> <Pine.LNX.4.44.0501121758180.2765-100000@localhost.localdomain> <20050112105315.2ac21173.akpm@osdl.org> <Pine.LNX.4.53.0501141433000.7044@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0501141433000.7044@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 02:55:27PM +0100, Tim Schmielau wrote:
> 2.6 seems in due need of such a patch.
> 
> I recently found out that 2.6 kernels degrade horribly when going into 
> swap. On my dual PIII-850 with as little as 256 mb ram, I can easily 
[snip]

I haven't tried the patch in question (unless it's in any Fedora
kernels), but I've noticed that the single biggest step to improve
swapping performance in 2.6 is to use the CFQ scheduler, not the AS
scheduler. (That's also why Red Hat/Fedora kernels use CFQ as the
default scheduler.)

-Barry K. Nathan <barryn@pobox.com>

