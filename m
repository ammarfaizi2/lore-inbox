Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269032AbUIXW5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269032AbUIXW5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269034AbUIXW5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:57:53 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:20299 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269032AbUIXW5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:57:46 -0400
Message-ID: <35fb2e5904092415572e58ee66@mail.gmail.com>
Date: Fri, 24 Sep 2004 23:57:40 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040923234520.GA7303@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200409230123.30858.thomas@habets.pp.se>
	 <20040923234520.GA7303@pclin040.win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004 01:45:20 +0200, Andries Brouwer <aebr@win.tue.nl> wrote:

> On Thu, Sep 23, 2004 at 01:23:08AM +0200, Thomas Habets wrote:

> > How about a sysctl that does "for the love of kbaek, don't ever kill these
> > processes when OOM. If nothing else can be killed, I'd rather you panic"?

> An aircraft company discovered that it was cheaper to fly its planes
> with less fuel on board. The planes would be lighter and use less fuel
> and money was saved. On rare occasions however the amount of fuel was
> insufficient, and the plane would crash. This problem was solved by
> the engineers of the company by the development of a special OOF
> (out-of-fuel) mechanism.

For the curious I have recently been reading about this (I'm a nervous
flyer, you wouldn't believe the kind of statistics I scare myself
with) and discovered the term RAT - RAM Air Turbine. In the event of
fuel running out, modern aircraft automatically drop this turbine and
generate sufficient power for navigation (and hopefully safe landing).
There's a famous early 1980s case in Canada known as the Gimli Glider
in which this actually ended up happing after a computer that
performed imperial/metric conversion failed and the manual calculation
was wrong - they coined a popular Canadian phrase because of this.

What we need is a mechanism to have a giant brainstraw emerge from the
front casing of the machine and suck the brains out of the guy running
a server with overcommit issues.

[ Alan has a working model super drinking straw from OLS - pity you
destroyed it. ]

Jon.
