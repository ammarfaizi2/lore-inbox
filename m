Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUJMIYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUJMIYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 04:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUJMIYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 04:24:54 -0400
Received: from canuck.infradead.org ([205.233.218.70]:56082 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S267678AbUJMIYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 04:24:52 -0400
Subject: Re: Fw: signed kernel modules?
From: David Woodhouse <dwmw2@infradead.org>
To: "Rusty Russell (IBM)" <rusty@au1.ibm.com>
Cc: Greg KH <greg@kroah.com>, dhowells <dhowells@redhat.com>,
       rusty@ozlabs.au.ibm.com.kroah.org, Arjan van de Ven <arjanv@redhat.com>,
       Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097626835.4013.37.camel@localhost.localdomain>
References: <30797.1092308768@redhat.com>
	 <20040812111853.GB25950@devserv.devel.redhat.com>
	 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
	 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
	 <10345.1097507482@redhat.com>
	 <1097507755.318.332.camel@hades.cambridge.redhat.com>
	 <1097534090.16153.7.camel@localhost.localdomain>
	 <1097570159.5788.1089.camel@baythorne.infradead.org>
	 <20041012190826.GB31353@kroah.com>
	 <1097626835.4013.37.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 13 Oct 2004 09:24:13 +0100
Message-Id: <1097655853.5178.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 (2.0.1-4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 10:20 +1000, Rusty Russell (IBM) wrote:
> On Wed, 2004-10-13 at 05:08, Greg KH wrote:
> > On Tue, Oct 12, 2004 at 09:35:59AM +0100, David Woodhouse wrote:
> > > 
> > > We know _precisely_ what the kernel looks at -- we wrote its linker. It
> > > really isn't that hard.
> > 
> > I agree.  We have to be able to detect improper header information for
> > unsigned modules today, nothing new there.
> 
> No, we *don't*.  We check that it's the right arch, and ELF, and not
> truncated.  Then we trust the contents.

"We have to" != "We actually do". He's right. You're right. We _have_ to
do this already, but we suck and actually we don't. David's working on
that, I believe.

-- 
dwmw2

