Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbUCEFCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 00:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUCEFCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 00:02:50 -0500
Received: from mx11.sac.fedex.com ([199.81.193.118]:32528 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP id S262212AbUCEFCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 00:02:48 -0500
Date: Fri, 5 Mar 2004 13:02:56 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Stuart Young <sgy-lkml@amc.com.au>
cc: David Ford <david+challenge-response@blue-labs.org>, jason@stdbev.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ACPI battery info failure after some period of time, 2.6.3-x
 and up
In-Reply-To: <200403051543.04300.sgy-lkml@amc.com.au>
Message-ID: <Pine.LNX.4.58.0403051259480.387@boston.corp.fedex.com>
References: <4047756D.2050402@blue-labs.org> <200403051520.40341.sgy-lkml@amc.com.au>
 <4048015D.6070308@blue-labs.org> <200403051543.04300.sgy-lkml@amc.com.au>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 03/05/2004
 01:02:40 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 03/05/2004
 01:02:46 PM,
	Serialize complete at 03/05/2004 01:02:46 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Mar 2004, Stuart Young wrote:

> ...and it just failed then, using 2.6.4-rc2 still.

have you tried applying patch from ...

ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.4/
acpi-20040220-2.6.4.diff.bz2


I'm on IBM X30, linux 2.6.4-rc2. No problem.


# uptime
 13:02:07 up  3:31,  4 users,  load average: 0.08, 0.07, 0.08

# cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mW
remaining capacity:      31780 mWh
present voltage:         12419 mV



Jeff.

