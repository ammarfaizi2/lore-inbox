Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbUCEJXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbUCEJXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:23:40 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:64939 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262281AbUCEJXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:23:36 -0500
Date: Fri, 5 Mar 2004 10:23:30 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
X-X-Sender: gandalf@tux.rsn.bth.se
To: Patrick McHardy <kaber@trash.net>
Cc: Matthew Strait <quadong@users.sourceforge.net>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] matching any helper in ipt_helper.c
In-Reply-To: <4047E231.60304@trash.net>
Message-ID: <Pine.LNX.4.58.0403051022150.17613@tux.rsn.bth.se>
References: <Pine.LNX.4.60.0403031947450.8957@dsl093-017-216.msp1.dsl.speakeasy.net>
 <40469E10.7080100@trash.net> <Pine.LNX.4.60.0403032150000.8957@dsl093-017-216.msp1.dsl.speakeasy.net>
 <4046BFB9.809@trash.net> <Pine.LNX.4.60.0403041500280.10634@dsl093-017-216.msp1.dsl.speakeasy.net>
 <4047A42E.6080307@trash.net> <Pine.LNX.4.60.0403041821010.21790@dsl093-017-216.msp1.dsl.speakeasy.net>
 <4047E231.60304@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004, Patrick McHardy wrote:

> Matthew Strait wrote:
> > Silly me, I assumed that the error was generated in user space.  Ok.  In
> > that case, let's forget translating "any" to "", because that just makes
> > the output of "iptables -L" confusing.  Sound good?
> >
>
> I actually meant translate in both direction. But no problem, I'm going
> to make a patch for iptables myself, if Martin is fine with it we can
> remove the childlevel match.

I'm fine with making ipt_helper able to match any helper if so desired.

/Martin
