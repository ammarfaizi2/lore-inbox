Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWCXVOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWCXVOQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWCXVOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:14:16 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:64964 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750816AbWCXVOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:14:16 -0500
Date: Sat, 25 Mar 2006 00:13:47 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: James Morris <jmorris@namei.org>
Cc: Arjan van de Ven <arjan@infradead.org>, yang.y.yi@gmail.com,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: Connector: Filesystem Events Connector v3
Message-ID: <20060324211347.GB12687@2ka.mipt.ru>
References: <4423673C.7000008@gmail.com> <1143183541.2882.7.camel@laptopd505.fenrus.org> <4c4443230603240624g132b8d37t1a271a8303b810bf@mail.gmail.com> <1143210523.2882.74.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0603241044080.26833@excalibur.intercode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603241044080.26833@excalibur.intercode>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 25 Mar 2006 00:13:48 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 10:44:29AM -0500, James Morris (jmorris@namei.org) wrote:
> On Fri, 24 Mar 2006, Arjan van de Ven wrote:
> 
> > > > > big overhead for the whole system,
> > > >
> > > > this is not true
> > > Hmm, Why?
> > 
> > audit only audits those syscalls (or rather, operations) you enable it
> > to audit basically.
> 
> Exactly, which takes about 2 minutes of code reading to discover.

There is another problem with audit - it is audit daemon, which will
receive and log all events which it actually should not process at all.
Audit is really for different things, more security related, while this
module adds informational events.
 
> - James
> -- 
> James Morris
> <jmorris@namei.org>

-- 
	Evgeniy Polyakov
