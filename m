Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWEIQAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWEIQAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWEIQAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:00:41 -0400
Received: from ns1.mvista.com ([63.81.120.158]:20099 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751110AbWEIQAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:00:40 -0400
Subject: Re: [RFC PATCH 01/35] Add XEN config options and disable
	unsupported config options.
From: Daniel Walker <dwalker@mvista.com>
To: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
In-Reply-To: <20060509151651.GI7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org>
	 <20060509085145.790527000@sous-sol.org>
	 <1147186032.21536.16.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <20060509151651.GI7834@cl.cam.ac.uk>
Content-Type: text/plain
Date: Tue, 09 May 2006 09:00:32 -0700
Message-Id: <1147190433.21536.28.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 16:16 +0100, Christian Limpach wrote:
> > >  
> > > +config X86_XEN
> > > +	bool "Xen-compatible"
> > > +	help
> > > +	  Choose this option if you plan to run this kernel on top of the
> > > +	  Xen Hypervisor.
> > > +
> > 
> > Couldn't you just add "depends on !SMP && .." to the config X86_XEN
> > block ? 
> 
> I guess you could, but it would make it rather non-obvious and tedious
> to enable X86_XEN then, wouldn't it?

I guess that true .. Might be better just to support SMP then ..

Daniel

