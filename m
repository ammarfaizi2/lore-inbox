Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUJOO2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUJOO2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267881AbUJOO2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:28:35 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19074 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267798AbUJOO2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:28:34 -0400
Date: Fri, 15 Oct 2004 16:28:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: David Woodhouse <dwmw2@infradead.org>
cc: David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <1097848897.13633.134.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.61.0410151614060.877@scrub.home>
References: <27277.1097702318@redhat.com>  <1097626296.4013.34.camel@localhost.localdomain>
  <1096544201.8043.816.camel@localhost.localdomain> 
 <1096411448.3230.22.camel@localhost.localdomain>  <1092403984.29463.11.camel@bach>
 <20040810002741.GA7764@kroah.com>  <1092189167.22236.67.camel@bach>
 <19388.1092301990@redhat.com>  <30797.1092308768@redhat.com> 
 <20040812111853.GB25950@devserv.devel.redhat.com>  <20040812200917.GD2952@kroah.com>
 <26280.1092388799@redhat.com>  <27175.1095936746@redhat.com>
 <30591.1096451074@redhat.com>  <10345.1097507482@redhat.com> 
 <1097507755.318.332.camel@hades.cambridge.redhat.com> 
 <1097534090.16153.7.camel@localhost.localdomain> 
 <1097570159.5788.1089.camel@baythorne.infradead.org>  <23446.1097777340@redhat.com>
 <Pine.LNX.4.61.0410151253360.7182@scrub.home> <1097848897.13633.134.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Oct 2004, David Woodhouse wrote:

> > Can someone please put this patch into some context, where it's not 
> > completely pointless? As is it does not make anything more secure.
> > Why is the kernel more trustable than a kernel module?
> 
> Because it's not that hard to put the kernel onto read-only media or in
> a flash chip to which you physically cut the Vpen line.

So put the modules there as well or put a ramdisk there that does module 
verifying and loading (and disable module loading after that).
Again, why is this patch necessary? I have to repeat my main point from 
the last mail: If someone could show me how I can trust the running 
kernel, it should be rather easy to extend the same measures to modules 
without the need for this patch.
Show me a way that this is not possible and I'll agree with you that this 
patch is needed.

bye, Roman
