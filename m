Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWEJUJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWEJUJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWEJUJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:09:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:59619 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932229AbWEJUJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:09:28 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 17/35] Segment register changes for Xen
Date: Wed, 10 May 2006 22:09:04 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Chris Wright <chrisw@sous-sol.org>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085154.802230000@sous-sol.org> <20060509071640.GA4150@ucw.cz>
In-Reply-To: <20060509071640.GA4150@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605102209.05004.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 09:16, Pavel Machek wrote:
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

It's not needed. Think about it.

-Andi
