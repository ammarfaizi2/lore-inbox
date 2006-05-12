Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWELA3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWELA3S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 20:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWELA3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 20:29:17 -0400
Received: from ozlabs.org ([203.10.76.45]:32908 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750722AbWELA3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 20:29:17 -0400
Subject: Re: [Xen-devel] Re: [RFC PATCH 17/35] Segment register changes for
	Xen
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
In-Reply-To: <20060509071640.GA4150@ucw.cz>
References: <20060509084945.373541000@sous-sol.org>
	 <20060509085154.802230000@sous-sol.org>  <20060509071640.GA4150@ucw.cz>
Content-Type: text/plain
Date: Fri, 12 May 2006 10:28:40 +1000
Message-Id: <1147393720.5599.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 07:16 +0000, Pavel Machek wrote:
> Hi!
> 
> > --- linus-2.6.orig/include/asm-i386/mach-default/mach_system.h
> > +++ linus-2.6/include/asm-i386/mach-default/mach_system.h
> > @@ -1,6 +1,8 @@
> >  #ifndef __ASM_MACH_SYSTEM_H
> >  #define __ASM_MACH_SYSTEM_H
> >  
> > +#define clearsegment(seg)
> 
> do {} while (0), please.

It's off-topic, but: why?

Rusty.
-- 
 ccontrol: http://ccontrol.ozlabs.org

