Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWCXS67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWCXS67 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWCXS67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:58:59 -0500
Received: from lixom.net ([66.141.50.11]:62942 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S964772AbWCXS66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:58:58 -0500
Date: Fri, 24 Mar 2006 12:58:12 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Kill machine numbers
Message-ID: <20060324185812.GE5538@pb15.lixom.net>
References: <1143178947.4257.78.camel@localhost.localdomain> <20060324062624.GA16815@pb15.lixom.net> <1143187298.3710.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143187298.3710.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 07:01:38PM +1100, Benjamin Herrenschmidt wrote:
> 
> > It would be very useful to print the ppc_md.name of the found machine
> > here, even without debugging enabled.
> 
> Not sure ... without debugging enabled, it's likely that you won't see
> anything that early anyway :)

True, but it'd be in the dmesg, and get printed when the console comes up.

> > It's really weird that IBM chose to use "chrp" to describe a
> > PAPR-compliant platform. I guess it's for historical reasons, but it
> > sure isn't CHRP any more.
> 
> Yup, I'm trying to get that changed in the architecture but even if I'm
> successful, we'll have to deal with existing machines.

Right, it was mostly a side comment.

> > > +      is _not_ "chrp" as this will be matched by the kernel to be a
> > > +      CHRP machine on 32 bits kernel or a pSeries on 64 bits kernels
> > 
> > ...or a PAPR-compliant machine on 64-bit kernels.
> > 
> > (Also, "xx-bit kernels", not "xx bits kernels").
> 
> yeah yeah :) Thanks for the review anyway !

Hey, I couldn't find much technical issues, so I ended up reading your
comments and picking errors there instead. :-)


-Olof
