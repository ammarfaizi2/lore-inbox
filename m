Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161453AbWFVXSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161453AbWFVXSd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWFVXSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:18:32 -0400
Received: from xenotime.net ([66.160.160.81]:31383 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030470AbWFVXSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:18:31 -0400
Date: Thu, 22 Jun 2006 16:21:16 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: mgross@linux.intel.com
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, mark.gross@intel.com
Subject: Re: [PATCH] riport LADAR driver
Message-Id: <20060622162116.f914f540.rdunlap@xenotime.net>
In-Reply-To: <20060622231604.GA5208@linux.intel.com>
References: <20060622144120.GA5215@linux.intel.com>
	<1151000401.3120.55.camel@laptopd505.fenrus.org>
	<20060622231604.GA5208@linux.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 16:16:04 -0700 mark gross wrote:

> Ok, I've addressed all of Randy's and your comments in the patch at appended to
> this email.  Its includes the re-shuffling of the functions to loose the
> declarations at the top of the file.  For the items I didn't address I have
> comments below.
> 
> Thanks for both of your inputs!
> 
> 
> On Thu, Jun 22, 2006 at 08:20:01PM +0200, Arjan van de Ven wrote:
> > On Thu, 2006-06-22 at 07:41 -0700, mark gross wrote:
> > > +
> > > +#undef PDEBUG
> > > +#ifdef RIPORT_DEBUG
> > > +#  define PDEBUG(fmt, args...) printk( KERN_DEBUG "riport: " fmt, ## args)
> > > +#else	/*  */
> > > +#  define PDEBUG(fmt, args...)
> > > +#endif	/*  */
> > 
> > what's wrong with prdebug ?
> > > +   
> 
> what is prdebug?

pr_debug() in linux/kernel.h


I'll look at the updated version later.

---
~Randy
