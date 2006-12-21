Return-Path: <linux-kernel-owner+w=401wt.eu-S1422934AbWLUNsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422934AbWLUNsK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 08:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422947AbWLUNsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 08:48:10 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:47749 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422934AbWLUNsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 08:48:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding:sender;
        b=mUyLxfu4DRFNpV67QntytlttotKIr6atKdlIzAwUf7sqlAsNQV2aIdlmeXSl2/GBexvUxjm+mqfPDm0d+HhR3q0oZfcfhGhq3adGunNHfeqzjrNF27wbyUQL9F9wuH1FEDSNn9wAzO4Fw3eYVro7OivK4x3ACLD4Pc9J4VKOnmk=
Subject: Re: [take28-resend_1->0 0/8] kevent: Generic event handling
	mechanism.
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
In-Reply-To: <20061221104918.GA16744@2ka.mipt.ru>
References: <3154985aa0591036@2ka.mipt.ru> <11666924573643@2ka.mipt.ru>
	 <20061221103539.GA4099@2ka.mipt.ru> <458A64E5.4050703@garzik.org>
	 <20061221104918.GA16744@2ka.mipt.ru>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 08:48:05 -0500
Message-Id: <1166708885.3749.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy,

On Thu, 2006-21-12 at 13:49 +0300, Evgeniy Polyakov wrote:

> So comment on its bugs, its design, implementation, ask questions,
> request features, show interest (even with 'I have no time right now,
> but will loko at it after in a week after vacations').
> 
> No one does it, so no one cares, so my behaviour.
> 

Please dont be discouraged by lack of attention - you are doing good
work.

I will concur with Jeff's point that since you are putting out a
profound conceptual changes, and there are many stake holders, it
requires scrutiny on their part. You need to build consensus in such a
situation. 
Some things that would help progress and build momentum:
- As i have advised you before, why dont you modify something like
existing libraries such as some of the loop thingies of desktop managers
such as kde/gnome or better things like libevent etc. Then write your
app on top of that? nobody is gonna run your httpd but if you
demonstrate that libevent is much better with your changes (with zero
changes to apps), people will migrate
- from a user space angle if people like Ulrich would state their views
on the current version you have. 
Note, they dont have to agree with you i.e the conclusion could be a
simple "agree to disagree".
- There really oughta be a limit on how long people are allowed to be
silent. After that IMO your code should just go in ...
 

cheers,
jamal

