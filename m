Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752035AbWG1Q1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbWG1Q1l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWG1Q1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:27:41 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:19616 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1752035AbWG1Q1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:27:40 -0400
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector
	feature
From: Arjan van de Ven <arjan@linux.intel.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
In-Reply-To: <1154103895.18669.5.camel@c-67-188-28-158.hsd1.ca.comcast.net>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
	 <1154102627.6416.13.camel@laptopd505.fenrus.org>
	 <1154103895.18669.5.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 18:27:28 +0200
Message-Id: <1154104048.6416.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 09:24 -0700, Daniel Walker wrote:
> On Fri, 2006-07-28 at 18:03 +0200, Arjan van de Ven wrote:
> 
> > ---
> >  arch/x86_64/Kconfig |   25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> 
> Could this be supported on more than just x86_64, it seems fairly
> generic ? 

I won't rule anything out, but for some it'll be impossible (such as
i386). It'll depend on the exact architecture I suppose.. for x86_64 a
gcc patch was needed (which took MONTHS to get in), I don't know how ppc
and such deal with this, I'll be talking to the respective maintainers
about this in the near future.... but I would not call it "fairly
generic".

