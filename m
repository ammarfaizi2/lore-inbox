Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270521AbUJTXsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270521AbUJTXsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270598AbUJTXr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:47:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54697 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270499AbUJTXrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:47:23 -0400
Date: Wed, 20 Oct 2004 19:46:59 -0400
From: Alan Cox <alan@redhat.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@redhat.com>
Subject: Re: Fwd: [Bug 3592] New: pppd "IPCP: timeout sending Config-Requests"
Message-ID: <20041020234659.GA26810@devserv.devel.redhat.com>
References: <20041019131240.A20243@flint.arm.linux.org.uk> <1098195468.8467.7.camel@deimos.microgate.com> <1098199942.2857.7.camel@deimos.microgate.com> <1098309449.12411.57.camel@localhost.localdomain> <1098315760.6006.13.camel@at2.pipehead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098315760.6006.13.camel@at2.pipehead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 06:42:40PM -0500, Paul Fulghum wrote:
> I'm not sure I would characterize using DCD
> for a serial connection indicator as odd.

The default setup trusts LCP closes sent between the two ends

> > in general serial error processing is not robust in the ppp code it
> > appears.
> 
> I'll look at what is needed to implement the
> new ldisc->hangup() method for the PPP line disciplines.

Thanks

