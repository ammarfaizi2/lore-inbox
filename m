Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269775AbUJANBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269775AbUJANBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 09:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269780AbUJANBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 09:01:55 -0400
Received: from dsl254-100-205.nyc1.dsl.speakeasy.net ([216.254.100.205]:25574
	"EHLO memeplex.com") by vger.kernel.org with ESMTP id S269775AbUJANBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 09:01:53 -0400
From: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
To: "Axel Gordon Grossklaus" <6grosskl@informatik.uni-hamburg.de>,
       "Martin Hermanowski" <martin@mh57.de>
Cc: "Roland Dreier" <roland.list@gmail.com>,
       <linux-thinkpad@linux-thinkpad.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Hard lockup on IBM ThinkPad T42
Date: Fri, 1 Oct 2004 09:01:08 -0400
Message-ID: <OMEGLKPBDPDHAGCIBHHJKEFHEKAA.aathan-linux-kernel-1542@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <20041001124642.GH5579@rzdspc3.informatik.uni-hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One thing in common with the hang I've reported on this list seems to be the network traffic bit.  My app does quite a bit of
traffic and uses thread mutex primitives, the SCHED_RR scheduler, and select() extensively.

A.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Axel Gordon
Grossklaus
Sent: Friday, October 01, 2004 8:47 AM
To: Martin Hermanowski
Cc: Roland Dreier; linux-thinkpad@linux-thinkpad.org;
linux-kernel@vger.kernel.org
Subject: Re: Hard lockup on IBM ThinkPad T42


On Thu, Sep 30, 2004 at 10:58:51PM +0200, Martin Hermanowski wrote:

moin,

> I have lockups in X running xlock with my T41p about once a month,
> running 2.6.7-rc3-mm1 with atheros and the XFree4.3 radeon driver.
>
> The only thing I noticed is that the hdd-led is constantly on when this
> happens.

i had that problem on my T41p (kernel oops when unlocking xlock, usually
if constant network traffic went on in the back).
updating madwifi to CVS version helped. (i had the version that comes
with suse 9.1 before).

tty, axel


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



