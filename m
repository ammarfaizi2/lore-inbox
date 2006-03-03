Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWCCUtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWCCUtd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWCCUtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:49:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44169 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932387AbWCCUtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:49:33 -0500
Date: Fri, 3 Mar 2006 12:48:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: [PATCH 10/15] EDAC: edac_mc_add_mc() fix [1/2]
Message-Id: <20060303124802.1c7fb95d.akpm@osdl.org>
In-Reply-To: <200603031103.08105.dsp@llnl.gov>
References: <200603021748.07381.dsp@llnl.gov>
	<20060302183143.6730d255.akpm@osdl.org>
	<200603031103.08105.dsp@llnl.gov>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> wrote:
>
> On Thursday 02 March 2006 18:31, Andrew Morton wrote:
> > Dave Peterson <dsp@llnl.gov> wrote:
> > >  This is part 1 of a 2-part patch set.  The code changes are split into
> > >  two parts to make the patches more readable.
> >
> > Will the code compile and run with just #1-of-2 applied?
> 
> It should compile.  Assuming that it does, would it still have been
> preferable to just combine the two into a single patch?

It's better as you had it.  First patch moves the functions without
changing them, the second patch changes them.  The mantra is "one concept
per patch".


