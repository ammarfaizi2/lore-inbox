Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWEIQiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWEIQiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWEIQiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:38:21 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:31662 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750716AbWEIQiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:38:20 -0400
Date: Tue, 9 May 2006 17:38:14 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 25/35] Add Xen time abstractions
Message-ID: <20060509163814.GM7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085157.908244000@sous-sol.org> <1147191789.21536.33.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147191789.21536.33.camel@c-67-180-134-207.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 09:23:08AM -0700, Daniel Walker wrote:
> On Tue, 2006-05-09 at 00:00 -0700, Chris Wright wrote:
> 
> > +timers-y			:= timers/
> > +timers-$(CONFIG_XEN)		:=
> 
> 
> Is this line suppose to be empty ?

Yes.  We have our own version of time.c which doesn't use any of the
timer code in timers but works for both i386 and x86_64 instead.

    christian

