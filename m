Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVJRVXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVJRVXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVJRVXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:23:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932134AbVJRVXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:23:52 -0400
Date: Tue, 18 Oct 2005 14:23:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: linas <linas@austin.ibm.com>
Cc: benh@kernel.crashing.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
Message-Id: <20051018142357.7eebedfe.akpm@osdl.org>
In-Reply-To: <20051018205710.GC29826@austin.ibm.com>
References: <1128404215.31063.32.camel@gaston>
	<20051011171315.2fe087e7.akpm@osdl.org>
	<1129076691.17365.250.camel@gaston>
	<20051018205710.GC29826@austin.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linas <linas@austin.ibm.com> wrote:
>
> On Wed, Oct 12, 2005 at 10:24:51AM +1000, Benjamin Herrenschmidt was heard to remark:
> > > > +#define BUILD_SHOW_FUNC_FIX(name, data)				\
> > > > +static ssize_t show_##name(struct device *dev,                  \
> > > > +			   struct device_attribute *attr,       \
> > > > +			   char *buf)	                        \
> > > > +{								\
> > 
> > Ahh no, the problem here is that stupid emacs is very bad with tab
> > and multi-line macros and just turns the whole thing into shit, so
> > I used spaces. Sorry, I'm not an emacs guru and don't know how to
> > work around that ...
> 
> Anyone who has tabstops set to 3 instead of 8

wtf?  Anyone who has tabstops set to three gets their kernel license revoked.

> will see broken-ness for
> macros like this no matter what. Suggest that the right policy is to use
> only spaces, and neve tabs, inside of macros.

It works OK for everyone else...
