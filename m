Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbUATMJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 07:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbUATMJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 07:09:44 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:14629 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S265403AbUATMJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 07:09:42 -0500
Message-Id: <5.1.0.14.2.20040120230738.03d3e008@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 20 Jan 2004 23:09:36 +1100
To: "Mark Williams (MWP)" <mwp@internode.on.net>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: TG3: very high CPU usage
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040120101606.GA26273@linux.comp>
References: <5.1.0.14.2.20040120204119.032e6ba8@171.71.163.14>
 <fa.e29fqcc.sick10@ifi.uio.no>
 <fa.g9joqss.1nneajs@ifi.uio.no>
 <fa.e29fqcc.sick10@ifi.uio.no>
 <5.1.0.14.2.20040120204119.032e6ba8@171.71.163.14>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:16 PM 20/01/2004, Mark Williams (MWP) wrote:
> > i have LOTS of IBM xSeries servers (IBM x335, x345, x440), all of which
> > have Broadcom BCM 5700 (tg3) NICs.
> > i drive them all at wire-rate gig-e with iSCSI.
> >
> > i'm yet to see any 'excessive' CPU load associated with tg3 relative to
> > tigon2 (AceNIC2) and Intel e1000 NICs.
>
>It might not effect those cards.
>I think the TG3 driver was changed to support the card im trying to use 
>(Netgear GA302T) and similar.

curious.

i remember from the Tigon2 days, it didn't matter if you used a NetGear 
card, an Alteon card, or an Alteon card ripped out of the inside of an 
ACEDirector switch -- they were all the same reference design.

i don't believe that anyone using the bcm5700 would deviate significantly 
beyond the reference design - there wouldn't be any reason to.

(the only variants are probably due to dual-port versions ... of course, 
i'm sure the tg3 driver authors will now correct me on the differences. 
<grin>).


cheers,

lincoln.

