Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266434AbUGOWg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266434AbUGOWg1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 18:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUGOWg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 18:36:27 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:61345 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266434AbUGOWgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 18:36:17 -0400
Subject: Re: [dm-devel] Re: namespaces (was Re: [Q] don't allow tmpfs to
	page out)
From: christophe varoqui <christophe.varoqui@free.fr>
To: device-mapper development <dm-devel@redhat.com>
Cc: Paul Jakma <paul@clubi.ie>, linux-kernel@vger.kernel.org
In-Reply-To: <20040715123148.GA23112@devserv.devel.redhat.com>
References: <1089878317.40f6392d7e365@imp5-q.free.fr>
	 <20040715080017.GB20889@devserv.devel.redhat.com>
	 <Pine.LNX.4.60.0407151329100.2622@fogarty.jakma.org>
	 <20040715123148.GA23112@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1089930946.6145.12.camel@zezette>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Jul 2004 00:35:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On jeu, 2004-07-15 at 14:31, Arjan van de Ven wrote:
> On Thu, Jul 15, 2004 at 01:31:08PM +0100, Paul Jakma wrote:
> > On Thu, 15 Jul 2004, Arjan van de Ven wrote:
> > 
> > >sure; namespaces can do a LOT
> > 
> > speaking of which, how does one use namespaces exactly? The kernel 
> > appears to maintain mount information per process, but how do you set 
> > this up?
> > 
> > neither 'man mount/namespace' nor 'appropos namespace' show up 
> > anything.
> 
> it's a clone() flag....

will execv() inherits the caller's namespace ?

regards,
cvaroqui

