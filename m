Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVDFVBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVDFVBB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 17:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVDFVBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 17:01:00 -0400
Received: from zoe.ndcservers.net ([216.23.188.144]:48265 "EHLO
	zoe.ndcservers.net") by vger.kernel.org with ESMTP id S262319AbVDFVAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 17:00:24 -0400
Message-ID: <03f201c53aeb$a42d1270$0201a8c0@ndciwkst01>
From: "mailinglist@unix-scripts.com" <mailinglists@unix-scripts.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <d2vu0u$oog$1@sea.gmane.org> <Pine.LNX.4.61.0504060209200.15520@montezuma.fsmlabs.com>
Subject: Re: kernel panic - not syncing: Fatal exception in interupt
Date: Wed, 6 Apr 2005 14:00:18 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2741.2600
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2742.200
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - zoe.ndcservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unix-scripts.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, sorry, i have to run with bridging support other wise the guests(UML's)
wont be able to communicate with the outside world.

Best Regards,

Shaun R

----- Original Message -----
From: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
To: "shaun" <mailinglists@unix-scripts.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, April 06, 2005 1:10 AM
Subject: Re: kernel panic - not syncing: Fatal exception in interupt


> On Tue, 5 Apr 2005, shaun wrote:
>
> > +Hardware Specs
> > Dual Xeon 800FSB
> > Intel Server Board
> > 4GB ECC DDR
> > 3ware 9500 Sata Raid Card
> > 5x200 GB sata drives in a raid 10 Config (1 hot spare)
> > Dual Nic
> >
> > +OS Specs
> > CentOS 3.4 running a custom 2.6.x kernel patched with UML SKA's Patch
> > eth0 is 0.0.0.0 promisc and assigned to a bridge (br0)
> > tuntap devices up
> > ebtables is enabled and loaded with rules
>
> Is it possible to run without the bridge for testing purposes, and be
> sure to put the normal networking load?
>
> > My problem is that every other week or so the machine crashes.  It never
> > dumps the error to the logs so all i have is a screen shot of the
console.
> > I have put some serious stress on this machine and have been unable to
> > duplicate the problem (running 20 guest UML's half running va-ctcs and
the
> > other half compiling a 2.6 kernel).   Below is a link to 2 screen shots
i
> > have (about 2 weeks apart).  I started off using a 2.6.10 kernel when
the
> > problem started.  Last time the machine crashed i built a 2.6.11.5
kernel
> > and disabled APM and ACPI in the kernel config.  Any body know whats
going
> > on here.
> >
> > http://www.unix-scripts.com/shaun/host-screenshot-1.png
> > http://www.unix-scripts.com/shaun/host-screenshot-2.png
> >
> > Kernel Config... http://www.unix-scripts.com/shaun/2.6.11.5-hr1_.config
> >
> > --
> > Best Regards,
> >
> > Shaun Reitan
> >
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>

