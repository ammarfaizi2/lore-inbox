Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268662AbUI3Hvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268662AbUI3Hvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 03:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268779AbUI3Hvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 03:51:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:31654 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268662AbUI3Hvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 03:51:52 -0400
Subject: Re: [Patch]: fix cpufrequency scaling on ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040930073935.GA18105@bogon.ms20.nix>
References: <20040928124057.GA3871@bogon.ms20.nix>
	 <1096461674.22092.9.camel@gaston>  <20040930073935.GA18105@bogon.ms20.nix>
Content-Type: text/plain
Message-Id: <1096530520.32754.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Sep 2004 17:48:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 17:39, Guido Guenther wrote:
> On Wed, Sep 29, 2004 at 10:41:14PM +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2004-09-28 at 22:40, Guido Guenther wrote:
> > > Hi,
> > > attached patch against 2.6.9-rc2 fixes cpufrequency scaling after resume
> > > on pmacs. Please apply.
> > 
> > It's actually still not clear wether we resume at the same speed we
> > had when going to sleep .. especially in the PMU cpufreq case...
> Thought about this too, especially since my pbook comes up with the
> lower frequency after pmdisk resume. Can you think of a simple way to
> read the current frequency that works an all currently supported models?

Nope, unfortunately...

Ben.


