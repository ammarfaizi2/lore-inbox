Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbUKDAw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUKDAw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUKDAtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:49:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14530 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262032AbUKDArr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:47:47 -0500
Date: Wed, 3 Nov 2004 19:45:31 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jim Nelson <james4765@verizon.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 5/5] documentation: Remove drivers/char/README.cycladesZ
Message-ID: <20041103214530.GD4716@logos.cnet>
References: <20041103152246.24869.2759.68945@localhost.localdomain> <20041103152314.24869.56459.88722@localhost.localdomain> <20041103133103.GB4109@logos.cnet> <41891AF3.9050800@verizon.net> <20041103150947.GA4695@logos.cnet> <418955D2.7000700@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418955D2.7000700@verizon.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 05:04:02PM -0500, Jim Nelson wrote:
> Marcelo Tosatti wrote:
> >On Wed, Nov 03, 2004 at 12:52:51PM -0500, Jim Nelson wrote:
> >
> >>You're right.  I'll send a patch to put README.cycladesZ in 
> >>Documentation/serial right now.
> >
> >
> >Also please only remove other README's if they are really obsolete. 
> >Whats your criteria for choosing what is obsolete?
> >
> 
> I erred on README.cycladesZ, I'll admit.  My apologies.  I normally contact 
> the maintainer *before* making a call like that.  Well, I'm kinda new to 
> this, and making mistakes is part of the process.

Sure, no problem. :)

> My unofficial "guidelines" for what needs to be looked at more closely 
> include: references to 2.0, 2.1, 2.2, 2.3, or 2.5 kernels, references to 
> external modules, dates of 2002 or earlier, or just a "wait a minute, I 
> don't think that's right". Not the prettiest technique, I know.

I think what your intention is good, we dont want obsolete files
which are not pertinent to v2.6 around - but you need to be careful. 

Old documents are not necessarily obsolete.

I would suggest sending all the patches to the respective maintainers,
removing only the ones which are _obviously_ obsolete (like the CyclomY 
which talks about upgrading from 2.0 to 2.2).

README.ecpa and README.scc, which you remove on your patches,
look valid and useful documentation to me. 

> >Move the rest to Documentation/serial, fine.
