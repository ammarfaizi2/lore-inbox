Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbUATJon (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 04:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbUATJon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 04:44:43 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:59070 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S265329AbUATJoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 04:44:38 -0500
Message-Id: <5.1.0.14.2.20040120204119.032e6ba8@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 20 Jan 2004 20:44:29 +1100
To: Andreas Hartmann <andihartmann@freenet.de>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: TG3: very high CPU usage
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <buirni$2t4$1@A88a8.a.pppool.de>
References: <fa.e29fqcc.sick10@ifi.uio.no>
 <fa.g9joqss.1nneajs@ifi.uio.no>
 <fa.e29fqcc.sick10@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[you may want to use linux-net@vger.kernel.org instead of linux-kernel; its 
possible that the tg3 folk lost your email in the flood]

At 08:17 PM 20/01/2004, Andreas Hartmann wrote:
>Hi,
>
>I searched for tg3 in lkml and found one more posting, dealing with these 
>problems (subject):
>
>bcm5705 with tg3 driver and high rx load -> bad system responsiveness
>
>There really seems to be a problem. Ronald Wahl pointed out, that the 
>driver from
>http://www.broadcom.com/drivers/downloaddrivers.php does not have the 
>problem. Maybe, we could both look for drivers from the hardware producer 
>and test them? I will do it when I'm back at work in two weeks.

how exactly are you "triggering" the high CPU load?  i.e. what is the 
server doing?  file-sharing?  NFS?  CIFS?  something else?

i have LOTS of IBM xSeries servers (IBM x335, x345, x440), all of which 
have Broadcom BCM 5700 (tg3) NICs.
i drive them all at wire-rate gig-e with iSCSI.

i'm yet to see any 'excessive' CPU load associated with tg3 relative to 
tigon2 (AceNIC2) and Intel e1000 NICs.


cheers,

lincoln.

