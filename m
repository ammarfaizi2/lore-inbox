Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268321AbUI3IqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268321AbUI3IqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 04:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUI3IqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 04:46:21 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:5262 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S269173AbUI3IqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 04:46:08 -0400
Date: Thu, 30 Sep 2004 10:43:34 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch]: fix cpufrequency scaling on ppc
Message-ID: <20040930084333.GD18105@bogon.ms20.nix>
References: <20040928124057.GA3871@bogon.ms20.nix> <1096461674.22092.9.camel@gaston> <20040930073935.GA18105@bogon.ms20.nix> <1096530520.32754.6.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096530520.32754.6.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 05:48:41PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2004-09-30 at 17:39, Guido Guenther wrote:
> > On Wed, Sep 29, 2004 at 10:41:14PM +1000, Benjamin Herrenschmidt wrote:
> > > On Tue, 2004-09-28 at 22:40, Guido Guenther wrote:
> > > > Hi,
> > > > attached patch against 2.6.9-rc2 fixes cpufrequency scaling after resume
> > > > on pmacs. Please apply.
> > > 
> > > It's actually still not clear wether we resume at the same speed we
> > > had when going to sleep .. especially in the PMU cpufreq case...
> > Thought about this too, especially since my pbook comes up with the
> > lower frequency after pmdisk resume. Can you think of a simple way to
> > read the current frequency that works an all currently supported models?
> 
> Nope, unfortunately...
Should the patch be applied anyway, it still way better than the current
situation.
Cheers,
 -- Guido
