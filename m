Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbTIST44 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbTIST4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:56:55 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:16530 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261732AbTISTyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:54:18 -0400
Date: Fri, 19 Sep 2003 21:54:12 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 4/13] use cpu_relax() in busy loop
Message-ID: <20030919215412.D22138@devserv.devel.redhat.com>
References: <20030918162522.E16499@osdlab.pdx.osdl.net> <20030918162748.F16499@osdlab.pdx.osdl.net> <20030918162930.G16499@osdlab.pdx.osdl.net> <20030918163156.H16499@osdlab.pdx.osdl.net> <1063956884.5394.3.camel@laptop.fenrus.com> <20030919124845.A27079@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030919124845.A27079@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Fri, Sep 19, 2003 at 12:48:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Sep 19, 2003 at 12:48:45PM -0700, Chris Wright wrote:
> * Arjan van de Ven (arjanv@redhat.com) wrote:
> > 
> > mdelay ?
> 
> Yeah, good point.  For these subsecond pauses mdelay() makes more sense.
> It'd be nice to get rid of long busy loops in general. 

yep; first step is making them grep-able by using mdelay ;)
