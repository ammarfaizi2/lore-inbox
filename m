Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUKJTKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUKJTKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUKJTKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:10:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56027 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262102AbUKJTJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:09:18 -0500
Date: Wed, 10 Nov 2004 13:41:36 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Tim Bird <tim.bird@am.sony.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: CELF interest in suspend-to-flash
Message-ID: <20041110154136.GA12444@logos.cnet>
References: <419256F8.3010305@am.sony.com> <1100109991.12290.41.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100109991.12290.41.camel@desktop.cunninghams>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 05:06:31AM +1100, Nigel Cunningham wrote:
> Hi.
> 
> On Thu, 2004-11-11 at 04:59, Tim Bird wrote:
> > Hi all,
> > 
> > Lately, the CE Linux Forum power management working group is showing some
> > interest in suspend-to-flash.  Is there any current work in this area?
> > 
> > Who should we talk to if we want to get involved with this (or lead
> > an effort if there isn't one)?
> 
> Can flash be treated as a swap device at the moment? If so, it might
> simply be a matter of specifying the same parameter used in swapon for
> the resume2= boot parameter.

Sure, you only need to have the flash as a block device (ie driven 
by the IDE code).

> If more work is required, I'd happily help, although I might be a little
> slow: I'm only work on this on a voluntary basis at the moment (looking
> for full time work, from next month though).
