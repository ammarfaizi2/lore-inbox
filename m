Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbTFGPu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 11:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTFGPu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 11:50:26 -0400
Received: from filesrv1.system-techniques.com ([199.33.245.55]:49817 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S262520AbTFGPuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 11:50:25 -0400
Date: Sat, 7 Jun 2003 12:03:31 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: James Stevenson <james@stev.org>
cc: chas williams <chas@cmf.nrl.navy.mil>,
       Werner Almesberger <wa@almesberger.net>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2) 
In-Reply-To: <Pine.LNX.4.44.0306071214110.19033-100000@god.stev.org>
Message-ID: <Pine.LNX.4.56.0306071200320.30661@filesrv1.baby-dragons.com>
References: <Pine.LNX.4.44.0306071214110.19033-100000@god.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello James ,

On Sat, 7 Jun 2003, James Stevenson wrote:
> On Fri, 6 Jun 2003, chas williams wrote:
> > In message <20030606210620.G3232@almesberger.net>,Werner Almesberger writes:
> > >TCP connections will survive route changes, interface
> > >removals, etc.
> > really?  if i remove my ethernet interface i expect all the
> > connections to die.

> Think of a latop with a normall ethernet card in it.
> When you unplug the cable it wont disconnect all the tcp
> connection on the interface so that you could re route everything though
> a wireless card.
	This anology is incorrect or at least can be circumvented .
	Ie: All physical interfaces could be unnumbered & th eloopback be
	the only interface with THE ip .  Then all routes lead to Rome as
	it were .
	Btw ,  This can & does work .  Hth ,  JimL
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
