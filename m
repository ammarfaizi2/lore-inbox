Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWCXIPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWCXIPI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 03:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422801AbWCXIPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 03:15:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55177 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422658AbWCXIPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 03:15:06 -0500
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector v3
From: Arjan van de Ven <arjan@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       yang.y.yi@gmail.com, linux-kernel@vger.kernel.org, matthltc@us.ibm.com
In-Reply-To: <20060324080839.GB5426@2ka.mipt.ru>
References: <4423673C.7000008@gmail.com>
	 <1143183541.2882.7.camel@laptopd505.fenrus.org>
	 <20060323.230649.11516073.davem@davemloft.net>
	 <20060323232345.1ca16f3f.akpm@osdl.org> <20060324080839.GB5426@2ka.mipt.ru>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 09:14:53 +0100
Message-Id: <1143188094.2882.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 11:08 +0300, Evgeniy Polyakov wrote:
> On Thu, Mar 23, 2006 at 11:23:45PM -0800, Andrew Morton (akpm@osdl.org) wrote:
> > "David S. Miller" <davem@davemloft.net> wrote:
> > >
> > > From: Arjan van de Ven <arjan@infradead.org>
> > >  Date: Fri, 24 Mar 2006 07:59:01 +0100
> > > 
> > >  > then make the syslog part optional.. if it's not already!
> > > 
> > >  Regardless I still think the filesystem events connector is a useful
> > >  facility.
> > 
> > Why's that?
> > 
> > (I'd viewed it as a fun thing, but I haven't really seen much pull for it,
> > and the scalability issues in there aren't trivial).
> 
> This module uses ratelimiting of event generation, so it will not hurt
> performance, but probably this should be somehow tuned from userspace.


.. so it has become unreliable for any kind of real use that depends on
getting complete events. Such as virus scanning or updatedb etc 

