Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422775AbWCXIRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbWCXIRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 03:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbWCXIRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 03:17:34 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:63933 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1422775AbWCXIRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 03:17:33 -0500
Date: Fri, 24 Mar 2006 11:16:53 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       yang.y.yi@gmail.com, linux-kernel@vger.kernel.org, matthltc@us.ibm.com
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector v3
Message-ID: <20060324081652.GD5426@2ka.mipt.ru>
References: <4423673C.7000008@gmail.com> <1143183541.2882.7.camel@laptopd505.fenrus.org> <20060323.230649.11516073.davem@davemloft.net> <20060323232345.1ca16f3f.akpm@osdl.org> <20060324080839.GB5426@2ka.mipt.ru> <1143188094.2882.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143188094.2882.22.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Mar 2006 11:16:53 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 09:14:53AM +0100, Arjan van de Ven (arjan@infradead.org) wrote:
> On Fri, 2006-03-24 at 11:08 +0300, Evgeniy Polyakov wrote:
> > On Thu, Mar 23, 2006 at 11:23:45PM -0800, Andrew Morton (akpm@osdl.org) wrote:
> > > "David S. Miller" <davem@davemloft.net> wrote:
> > > >
> > > > From: Arjan van de Ven <arjan@infradead.org>
> > > >  Date: Fri, 24 Mar 2006 07:59:01 +0100
> > > > 
> > > >  > then make the syslog part optional.. if it's not already!
> > > > 
> > > >  Regardless I still think the filesystem events connector is a useful
> > > >  facility.
> > > 
> > > Why's that?
> > > 
> > > (I'd viewed it as a fun thing, but I haven't really seen much pull for it,
> > > and the scalability issues in there aren't trivial).
> > 
> > This module uses ratelimiting of event generation, so it will not hurt
> > performance, but probably this should be somehow tuned from userspace.
> 
> 
> .. so it has become unreliable for any kind of real use that depends on
> getting complete events. Such as virus scanning or updatedb etc 

That is why it should be tunable.
Everything has a price.

-- 
	Evgeniy Polyakov
