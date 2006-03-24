Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWCXIJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWCXIJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 03:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWCXIJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 03:09:37 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:55992 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932142AbWCXIJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 03:09:35 -0500
Date: Fri, 24 Mar 2006 11:08:39 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, arjan@infradead.org,
       yang.y.yi@gmail.com, linux-kernel@vger.kernel.org, matthltc@us.ibm.com
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector v3
Message-ID: <20060324080839.GB5426@2ka.mipt.ru>
References: <4423673C.7000008@gmail.com> <1143183541.2882.7.camel@laptopd505.fenrus.org> <20060323.230649.11516073.davem@davemloft.net> <20060323232345.1ca16f3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323232345.1ca16f3f.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Mar 2006 11:08:40 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 11:23:45PM -0800, Andrew Morton (akpm@osdl.org) wrote:
> "David S. Miller" <davem@davemloft.net> wrote:
> >
> > From: Arjan van de Ven <arjan@infradead.org>
> >  Date: Fri, 24 Mar 2006 07:59:01 +0100
> > 
> >  > then make the syslog part optional.. if it's not already!
> > 
> >  Regardless I still think the filesystem events connector is a useful
> >  facility.
> 
> Why's that?
> 
> (I'd viewed it as a fun thing, but I haven't really seen much pull for it,
> and the scalability issues in there aren't trivial).

This module uses ratelimiting of event generation, so it will not hurt
performance, but probably this should be somehow tuned from userspace.

-- 
	Evgeniy Polyakov
