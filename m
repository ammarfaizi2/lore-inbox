Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265520AbUFWOrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265520AbUFWOrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUFWOq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:46:59 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:49289 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S265974AbUFWOq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:46:28 -0400
Date: Wed, 23 Jun 2004 16:46:27 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Mikael Bouillot <xaajimri@corbac.com>
Cc: linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Subject: Re: Forcedeth driver bug
Message-Id: <20040623164627.3234bc29@phoebee>
In-Reply-To: <20040623142936.GA10440@mail.nute.net>
References: <20040623142936.GA10440@mail.nute.net>
X-Mailer: Sylpheed-Claws 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.2 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004 14:29:36 +0000
Mikael Bouillot <xaajimri@corbac.com> bubbled:

>   Hi all,
> 
>   I'm having trouble with the forcedeth driver in kernel version 2.6.7.
> >From what I can see, it seems that incoming packets sometime get stuck
> on their way in.
> 
>   What happens is this: some packet enters the NIC, and for some reason,
> it doesn't come out of the driver. As soon as another incoming packet
> gets in, both packets are handed down by the driver.

Do you really know that the driver don't get the stuck packet. Or is it possible
that the kernels network stack does the fault?

I'm asking because I have a similar problem with udp and kernel 2.6.7-rc2-mm2.
My sendto gets stuck sometimes and only continues if the kernel handles another
network packet.

But maybe my problem is a totally different one.

Regards,
Martin

-- 
MyExcuse:
YOU HAVE AN I/O ERROR -> Incompetent Operator error

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>
