Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVJLA1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVJLA1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVJLA1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:27:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:24464 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932351AbVJLA1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:27:18 -0400
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
In-Reply-To: <20051011171052.3e1d00b6.akpm@osdl.org>
References: <1128404215.31063.32.camel@gaston>
	 <20051011171052.3e1d00b6.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 10:23:07 +1000
Message-Id: <1129076588.17365.245.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 17:10 -0700, Andrew Morton wrote:

> > +
> > +	/* Alloc & initialize state */
> > +	wf_smu_sys_fans = kmalloc(sizeof(struct wf_smu_sys_fans_state),
> > +					GFP_KERNEL);
> > +	if (wf_smu_sys_fans == NULL) {
> > +		printk(KERN_WARNING "windfarm: Memory allocation error"
> > +		       " max fan speed\n");
> > +		goto fail;
> > +	}
> > +       	wf_smu_sys_fans->ticks = 1;
> 
> whitespace broke.

How so ? You mean the GFP_KERNEL a little bit too much on the right ? :)

Ben.


