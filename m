Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbUKJTsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbUKJTsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUKJTsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:48:24 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:57769
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262039AbUKJTsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:48:18 -0500
Subject: Re: CELF interest in suspend-to-flash
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Tim Bird <tim.bird@am.sony.com>, LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20041110154136.GA12444@logos.cnet>
References: <419256F8.3010305@am.sony.com>
	 <1100109991.12290.41.camel@desktop.cunninghams>
	 <20041110154136.GA12444@logos.cnet>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 10 Nov 2004 20:39:52 +0100
Message-Id: <1100115592.3405.36.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 13:41 -0200, Marcelo Tosatti wrote:
> > On Thu, 2004-11-11 at 04:59, Tim Bird wrote:
> > > Hi all,
> > > 
> > > Lately, the CE Linux Forum power management working group is showing some
> > > interest in suspend-to-flash.  Is there any current work in this area?
> > > 
> > > Who should we talk to if we want to get involved with this (or lead
> > > an effort if there isn't one)?
> > 
> > Can flash be treated as a swap device at the moment? If so, it might
> > simply be a matter of specifying the same parameter used in swapon for
> > the resume2= boot parameter.
> 
> Sure, you only need to have the flash as a block device (ie driven 
> by the IDE code).

That's true, if you are talking about Compact FLash which pretends to be
a harddisk, but I assume that the embedded people are talking about raw
FLASH chips. It's possible do this, but it will need some tweaks to the
MTD code

tglx





