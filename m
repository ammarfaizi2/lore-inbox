Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268907AbUJUAH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268907AbUJUAH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269066AbUJUADN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:03:13 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:19520 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270452AbUJUAAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:00:31 -0400
Subject: Re: Fwd: [Bug 3592] New: pppd "IPCP: timeout sending
	Config-Requests"
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20041020234659.GA26810@devserv.devel.redhat.com>
References: <20041019131240.A20243@flint.arm.linux.org.uk>
	 <1098195468.8467.7.camel@deimos.microgate.com>
	 <1098199942.2857.7.camel@deimos.microgate.com>
	 <1098309449.12411.57.camel@localhost.localdomain>
	 <1098315760.6006.13.camel@at2.pipehead.org>
	 <20041020234659.GA26810@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1098316806.6006.23.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 20 Oct 2004 19:00:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 18:46, Alan Cox wrote:
> On Wed, Oct 20, 2004 at 06:42:40PM -0500, Paul Fulghum wrote:
> > I'm not sure I would characterize using DCD
> > for a serial connection indicator as odd.
> 
> The default setup trusts LCP closes sent between the two ends

Yes.

In the case of this bug report, it looks like Window NT4
is dropping the connection without sending the LCP close.
That is crappy behavior.

DCD makes a good check on the physical layer in case
your POTS line is on the crackly side.
May I never suffer dialup again :-P

-- 
Paul Fulghum
paulkf@microgate.com


