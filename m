Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTLNWDt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 17:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbTLNWDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 17:03:49 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:2055 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262683AbTLNWDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 17:03:47 -0500
Date: Sun, 14 Dec 2003 23:03:46 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
Message-ID: <20031214220346.GA11927@win.tue.nl>
References: <20031212131704.A26577@animx.eu.org> <20031212194439.GB11215@win.tue.nl> <20031212163545.A26866@animx.eu.org> <20031213132208.GA11523@win.tue.nl> <20031213171800.A28547@animx.eu.org> <20031214144046.GA11870@win.tue.nl> <20031214112728.A8201@animx.eu.org> <20031214202741.GA11909@win.tue.nl> <20031214162348.A8691@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031214162348.A8691@animx.eu.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 14, 2003 at 04:23:48PM -0500, Wakko Warner wrote:

> > > > Or does it suffice to take */255/63 always?
> > > 
> > > I would say most cases use the 255/63
> > 
> > Good. So you can try constant geometry setting with *fdisk.
> > 
> > > with drives >4gb.  Is there anyway to query the bios to ask it?
> > 
> > Yes, and that is what the kernel used to do.
> > In general, however, the answer is unreliable. 
> 
> anyway to get this unreliable answer back?  =)

Easy enough, the code is still there, just the result is no longer used.

But unless you have good reason, you should not wish those old times
back. This geometry stuff has caused such a large amount of pain.

Set your geometry to the constant */255/63 - depending on precisely
what you did, that may already have been what you got from 2.4 anyway.
Complain if you have troubles - specify BIOS type, geometry, operating
system that has problems booting.

I hope we'll find out that everything can be made to work without
kernel support.

