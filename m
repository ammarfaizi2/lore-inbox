Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWEAUlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWEAUlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWEAUlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:41:53 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:49289 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S932241AbWEAUlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:41:52 -0400
Date: Mon, 1 May 2006 22:41:50 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: David Vrabel <dvrabel@cantab.net>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net
Subject: Re: IP1000 gigabit nic driver
Message-ID: <20060501204150.GC1450@xi.wantstofly.org>
References: <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com> <20060428113755.GA7419@fargo> <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI> <1146306567.1642.3.camel@localhost> <20060429122119.GA22160@fargo> <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost> <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <20060501203847.GA7419@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501203847.GA7419@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 10:38:47PM +0200, Francois Romieu wrote:

> > -/* Minimum number of miliseconds used to toggle MDC clock during
> > +/* Minimum number of nanoseconds used to toggle MDC clock during
> >   * MII/GMII register access.
> >   */
> > -#define         IPG_PC_PHYCTRLWAIT           0x01
> > +#define		IPG_PC_PHYCTRLWAIT_NS		200
> 
> I would have expected a cycle of 400 ns (p.72/77 of the datasheet)
> for a 2.5 MHz clock. Why is it cut by a two factor ?

200 ns high + 200 ns low = 400 ns clock period?
