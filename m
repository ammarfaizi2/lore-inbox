Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbTIZDdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 23:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTIZDdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 23:33:12 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:49026 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S261856AbTIZDdK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 23:33:10 -0400
Date: Thu, 25 Sep 2003 23:33:06 -0400
From: Yaroslav Halchenko <yoh@onerussian.com>
To: Milton Miller <miltonm@bga.com>, Greg KH <greg@kroah.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [yoh@onerussian.com: Re: USB problem. 'irq 9: nobody cared!']
Message-ID: <20030926033306.GA27234@washoe.rutgers.edu>
Mail-Followup-To: Milton Miller <miltonm@bga.com>, Greg KH <greg@kroah.com>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry guys - probably I'm tired now not yesterday - that time I booted
in old good test4-bk3 (I didn't run lilo before boot).

In recent test5-bk12 with that patch I still get the same problem
irq 9: nobody cared!
Call Trace:
 [<c010b71a>] __report_bad_irq+0x2a/0x90
 [<c010b810>] note_interrupt+0x70/0xb0
..
Disabling IRQ #9


Sorry about this...

I wish I could help more to resolve this problem

Sincerely
Yarik





----- Forwarded message from Yaroslav Halchenko <yoh@onerussian.com> -----

From: Yaroslav Halchenko <yoh@onerussian.com>
To: Milton Miller <miltonm@bga.com>, Greg KH <greg@kroah.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: USB problem. 'irq 9: nobody cared!'
Mail-Followup-To: Milton Miller <miltonm@bga.com>, Greg KH <greg@kroah.com>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>

I've tried again with recent bk12 kernel and this patch worked... 

May be I was too tired and actually didn't patch the first time I
tried, and then reported to you that it didn't help - I'm sorry. Will
check later if it is the case.

Thanx for your help

Sincerely 
Yarik

On Wed, Sep 24, 2003 at 05:57:27PM -0500, Milton Miller wrote:
> 
> Yaroslav Halchenko wrote:
> > Greg KH wrote:
> > > Did you try David Brownell's patch for this issue?
> > Can you please point which one exactly? I've tried to locate patch you
> > meant but it is too much of USB staff is happening now seems to me.
> 
> 
> I'm guessing this one: Re: irq 11: nobody cared! is back
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106399942523614&w=2
> 
> 
> milton
                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]

----- End forwarded message -----
                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
