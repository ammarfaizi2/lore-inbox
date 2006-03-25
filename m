Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWCYGkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWCYGkP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 01:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWCYGkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 01:40:15 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:54668
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751087AbWCYGkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 01:40:14 -0500
Date: Fri, 24 Mar 2006 22:39:43 -0800
From: Greg KH <greg@kroah.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Andrew Morton <akpm@osdl.org>, Mark Lord <lkml@rtr.ca>,
       "David J. Wallace" <katana@onetel.com>, sdhci-devel@list.drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [Sdhci-devel] Submission to the kernel?
Message-ID: <20060325063943.GB22214@kroah.com>
References: <4419FA7A.4050104@cogweb.net> <200603171042.52589.katana@onetel.com> <441AD537.5080403@rtr.ca> <441AD9C3.2090703@drzeus.cx> <20060317170126.GB32281@kroah.com> <441AEEBB.10104@drzeus.cx> <20060325023942.GC6416@kroah.com> <4424D9CA.7090303@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4424D9CA.7090303@drzeus.cx>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 06:48:58AM +0100, Pierre Ossman wrote:
> Greg KH wrote:
> > Tried it out and it works great (also see it's in 2.6.16-git9 now).  Hm,
> > my laptop's slot also supports xD cards, which your patch set does not
> > yet support, right?
> >
> >   
> 
> And will never do. Different hardware, interface and protocol.

Doh, you are right, sorry about that.  It's a totally different PCI
device, I should have looked before writing that.

Anyway, thanks again, this is working fine here.

greg k-h
