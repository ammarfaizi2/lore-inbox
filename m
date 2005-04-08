Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVDHF4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVDHF4E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 01:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVDHF4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 01:56:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49628 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262691AbVDHFz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 01:55:57 -0400
Date: Fri, 8 Apr 2005 01:55:01 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: Kay Sievers <kay.sievers@vrfy.org>, Ian Campbell <ijc@hellion.org.uk>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
In-Reply-To: <1112931695.28858.188.camel@uganda>
Message-ID: <Xine.LNX.4.44.0504080152540.24105-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005, Evgeniy Polyakov wrote:

> > > Sure, but seems I need to ask again: What is the exact reason not to implement
> > > the muticast message multiplexing/subscription part of the connector as a
> > > generic part of netlink? That would be nice to have and useful for other
> > > subsystems too as an option to the current broadcast.
> > 
> > This is a good point, in general, consider generically extending Netlink 
> > itself instead of creating these separate things.
> 

> Connector requires it's own registration technique for
> 1. hide all transport [netlink] layer from higher protocols which use
> connector

Why?

> 2. create different group appointment for the given connector's ID
> [it was different, now new group which is eqal to idx field is appointed
> to 
> the new callback]

I don't understand.

> 3. provide more generic set of ids

What do you mean by "ids"?


- James
-- 
James Morris
<jmorris@redhat.com>


