Return-Path: <linux-kernel-owner+w=401wt.eu-S1750770AbWL2KkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWL2KkQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 05:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWL2KkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 05:40:16 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:21609 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750770AbWL2KkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 05:40:15 -0500
Date: Fri, 29 Dec 2006 11:40:14 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
In-Reply-To: <20061228163127.8234fac9.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.63.0612290318470.9289@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
 <20061228124644.4e1ed32b.akpm@osdl.org> <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de>
 <20061228210803.GR17561@ftp.linux.org.uk>
 <Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de>
 <20061228213438.GD20596@flint.arm.linux.org.uk> <20061228133246.ad820c6a.randy.dunlap@oracle.com>
 <20061228214830.GF20596@flint.arm.linux.org.uk> <20061228161019.b876e10b.randy.dunlap@oracle.com>
 <Pine.LNX.4.63.0612290131500.27367@gockel.physik3.uni-rostock.de>
 <20061228163127.8234fac9.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006, Randy Dunlap wrote:

> Yep, right, if I already had all of that cross-build stuff setup,
> it wouldn't be a big deal.  But getting it all setup is a big deal
> (to me).

Well, I didn't want to say that you specifically should do that. ;-)

OTOH, if you are interested, setting it up isn't nearly as difficult as 
it seems. http://kegel.com/crosstool/ almost makes it a no-brainer.
It's some years ago that I set up mine, but if you want I'll write up 
a mini-howto about my setup. Al Viro also deschribed his setup:
http://lkml.org/lkml/2004/10/28/17

(and if you are frightened by the braindamage of my sched-removal-tools:
no, crosscompiling is nowhere as complicated as that.)

Tim
