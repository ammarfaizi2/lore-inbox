Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbUKJTwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUKJTwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUKJTwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:52:21 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:50322 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262052AbUKJTwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:52:14 -0500
Subject: Re: CELF interest in suspend-to-flash
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: tglx@linutronix.de
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Tim Bird <tim.bird@am.sony.com>, LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <1100115592.3405.36.camel@thomas>
References: <419256F8.3010305@am.sony.com>
	 <1100109991.12290.41.camel@desktop.cunninghams>
	 <20041110154136.GA12444@logos.cnet>  <1100115592.3405.36.camel@thomas>
Content-Type: text/plain
Message-Id: <1100116269.3876.12.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 11 Nov 2004 06:51:09 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-11 at 06:39, Thomas Gleixner wrote:
> On Wed, 2004-11-10 at 13:41 -0200, Marcelo Tosatti wrote:
> > > On Thu, 2004-11-11 at 04:59, Tim Bird wrote:
> > > > Hi all,
> > > > 
> > > > Lately, the CE Linux Forum power management working group is showing some
> > > > interest in suspend-to-flash.  Is there any current work in this area?
> > > > 
> > > > Who should we talk to if we want to get involved with this (or lead
> > > > an effort if there isn't one)?
> > > 
> > > Can flash be treated as a swap device at the moment? If so, it might
> > > simply be a matter of specifying the same parameter used in swapon for
> > > the resume2= boot parameter.
> > 
> > Sure, you only need to have the flash as a block device (ie driven 
> > by the IDE code).
> 
> That's true, if you are talking about Compact FLash which pretends to be
> a harddisk, but I assume that the embedded people are talking about raw
> FLASH chips. It's possible do this, but it will need some tweaks to the
> MTD code

Alternatively, a new module could be written for suspend to read/write
to it. If your idea is just tweaks, it will probably be quicker to
implement (and... I don't have access to the hardware).

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

