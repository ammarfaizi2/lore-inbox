Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422686AbWF0WcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686AbWF0WcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422687AbWF0WcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:32:17 -0400
Received: from xenotime.net ([66.160.160.81]:28134 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422686AbWF0WcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:32:16 -0400
Date: Tue, 27 Jun 2006 15:35:01 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Cc: haveblue@us.ibm.com, akpm@osdl.org, mel@skynet.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] bootmem: miscellaneous coding style fixes
Message-Id: <20060627153501.105426f7.rdunlap@xenotime.net>
In-Reply-To: <cda58cb80606271222x39eb9540y9a3246df8405b01c@mail.gmail.com>
References: <449FDD02.2090307@innova-card.com>
	<1151344691.10877.44.camel@localhost.localdomain>
	<44A12A91.5030704@innova-card.com>
	<1151429185.24103.8.camel@localhost.localdomain>
	<cda58cb80606271222x39eb9540y9a3246df8405b01c@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 21:22:29 +0200 Franck Bui-Huu wrote:

> 2006/6/27, Dave Hansen <haveblue@us.ibm.com>:
> > On Tue, 2006-06-27 at 14:54 +0200, Franck Bui-Huu wrote:
> > >  }
> > > +
> > >  /*
> > >   * link bdata in order
> > >   */
> > >  static void __init link_bootmem(bootmem_data_t *bdata)
> > >  {
> > >         bootmem_data_t *ent;
> > > +
> > >         if (list_empty(&bdata_list)) {
> >
> > I'd discourage you from including too many of these in your patches.
> > One or two is probably OK.  But, there are a bunch of them, and it isn't
> > clear CodingStyle to have spacing like this either way.  I'd drop them.
> >
> 
> IMHO they make the code obviously more readable and obviously do not
> add any new bugs. So why drop them ?

I'd say the change is preferred even if it's not in CodingStyle.

---
~Randy
