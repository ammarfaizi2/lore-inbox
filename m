Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbVJRU5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbVJRU5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 16:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbVJRU5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 16:57:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:57832 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751503AbVJRU5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 16:57:17 -0400
Date: Tue, 18 Oct 2005 15:57:10 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
Message-ID: <20051018205710.GC29826@austin.ibm.com>
References: <1128404215.31063.32.camel@gaston> <20051011171315.2fe087e7.akpm@osdl.org> <1129076691.17365.250.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129076691.17365.250.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 10:24:51AM +1000, Benjamin Herrenschmidt was heard to remark:
> > > +#define BUILD_SHOW_FUNC_FIX(name, data)				\
> > > +static ssize_t show_##name(struct device *dev,                  \
> > > +			   struct device_attribute *attr,       \
> > > +			   char *buf)	                        \
> > > +{								\
> 
> Ahh no, the problem here is that stupid emacs is very bad with tab
> and multi-line macros and just turns the whole thing into shit, so
> I used spaces. Sorry, I'm not an emacs guru and don't know how to
> work around that ...

Anyone who has tabstops set to 3 instead of 8 will see broken-ness for
macros like this no matter what. Suggest that the right policy is to use
only spaces, and neve tabs, inside of macros.

--linas
