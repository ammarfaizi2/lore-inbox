Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262986AbVCDS7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbVCDS7d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbVCDSzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:55:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:4561 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262984AbVCDSlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:41:53 -0500
Date: Fri, 4 Mar 2005 10:41:24 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, dtor_core@ameritech.net,
       Chris Wright <chrisw@osdl.org>, jgarzik@pobox.com, olof@austin.ibm.com,
       paulus@samba.org, rene@exactcode.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
Message-ID: <20050304184124.GC29857@kroah.com>
References: <20050303225542.GB16886@austin.ibm.com> <20050303175951.41cda7a4.akpm@osdl.org> <20050304022424.GA26769@austin.ibm.com> <20050304055451.GN5389@shell0.pdx.osdl.net> <20050303220631.79a4be7b.akpm@osdl.org> <4227FC5C.60707@pobox.com> <20050304062016.GO5389@shell0.pdx.osdl.net> <20050303222335.372d1ad2.akpm@osdl.org> <20050304162755.GA28179@kroah.com> <Pine.LNX.4.58.0503041031110.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503041031110.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 10:38:10AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 4 Mar 2005, Greg KH wrote:
> > 
> > Ok, based on consensus, I've applied this one too.
> 
> Btw, I don't think your process works. You never really gave people the
> time to object. So for that reason you applied the first trivial raid6
> thing, and it turned out to be wrong.

I agree.

> I think the patches need to have a rule like "they live outside the sucker 
> tree for at least two days". And during that time, anybody can vote them 
> down (which would move them to "unapplied" status, at which point somebody 
> else might decide that for _their_ tree it's still the right thing to do).
> 
> And if at the end of two days, they still haven't gotten enough "yes"  
> votes, they'd go into "limbo" status, with one extra grace-period (ie a
> reminder on whatever list about a patch that is dying). And if it can't 
> get enough "yeah, sure" votes even after that, it goes into the same 
> "unapplied" list.
> 
> In other words, I think this really does want some automation. It
> shouldn't be fully automated (at the very least, somebody needs to
> actually check that things patch and fix up the changeset comments etc),
> but the _rules_ should be automated. Otherwise they'll always be broken
> because of "_this_ time it's obvious", which is against the point.

Ok, Chris and I are going to sit down and work this all out on Tuesday.
I'll hold off on applying or releasing anything else until we fully
describe the process, and set up the infrastructure.

I'll slow down now :)

thanks,

greg k-h
