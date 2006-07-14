Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422758AbWGNURK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWGNURK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422751AbWGNURK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:17:10 -0400
Received: from canuck.infradead.org ([205.233.218.70]:4073 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1422761AbWGNURJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:17:09 -0400
Subject: Re: 2.6.18 Headers - Long
From: David Woodhouse <dwmw2@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jim Gifford <maillist@jg555.com>, LKML <linux-kernel@vger.kernel.org>,
       ralf@linux-mips.org
In-Reply-To: <1152905987.3159.46.camel@laptopd505.fenrus.org>
References: <44B443D2.4070600@jg555.com>
	 <1152836749.31372.36.camel@shinybook.infradead.org>
	 <44B6FEDE.4040505@jg555.com> <1152903332.3191.87.camel@pmac.infradead.org>
	 <44B7F062.8040102@jg555.com>
	 <1152905987.3159.46.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 21:16:42 +0100
Message-Id: <1152908202.3191.98.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 21:39 +0200, Arjan van de Ven wrote:
> On Fri, 2006-07-14 at 12:28 -0700, Jim Gifford wrote:
> > Unfortunately, a lot programs out there are using page.h, and a lot of 
> > people are using that in their programs. 
> 
> .... and they're all broken.... 

More to the point, now we're doing this from upstream we can be
_consistent_ about telling them to sod off and fix their broken crap.

We no longer have to deal with cries of 'but it works on $SOMEDISTRO'
when another distro tries to impose some sanity rather than just
pandering to it.

Kernel headers are _not_ a library of random crap for userspace to use.

-- 
dwmw2

