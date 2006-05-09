Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWEIW6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWEIW6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWEIW6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:58:19 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:57986 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751401AbWEIW6S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:58:18 -0400
Date: Tue, 9 May 2006 16:01:18 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 04/35] Hypervisor interface header files.
Message-ID: <20060509230118.GB24291@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085148.485343000@sous-sol.org> <200605100043.05241.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605100043.05241.ioe-lkml@rameria.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Oeser (ioe-lkml@rameria.de) wrote:
> On Tuesday, 9. May 2006 09:00, Chris Wright wrote:
> > Define macros and inline functions for doing hypercalls into the
> > hypervisor.
> > +static inline int
> > +HYPERVISOR_set_trap_table(
> > +	struct trap_info *table)
> > +{
> > +	return _hypercall1(int, set_trap_table, table);
> > +}
> 
> This is outright ugly and non-conformant to 
> Documentation/CodingStyle Chapter 2

Yes, it's non-conformant, will fix that up.

thanks,
-chris
