Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263372AbSJFK00>; Sun, 6 Oct 2002 06:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263373AbSJFK00>; Sun, 6 Oct 2002 06:26:26 -0400
Received: from adsl-66-136-198-157.dsl.austtx.swbell.net ([66.136.198.157]:16770
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S263372AbSJFK0Z>; Sun, 6 Oct 2002 06:26:25 -0400
Subject: Re: QLogic Linux failover/Load Balancing ER0000000020860
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: jbradford@dial.pipex.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210061019.g96AJ9KA001206@darkstar.example.net>
References: <200210061019.g96AJ9KA001206@darkstar.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1033900283.6413.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 06 Oct 2002 05:31:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 05:19, jbradford@dial.pipex.com wrote:
> > > Linux is not allowed to address LUNs out of sequence, so searching for
> > > further LUN numbers stops after 0, since 2 is the next one. 
> 
> That's not true:
> 
> CONFIG_SCSI_REPORT_LUNS:
> 
> If you want to build with SCSI REPORT LUNS support i the kernel, say Y here.
> The REPORT LUNS command is useful for devices (such as disk arrays) with large numbers of LUNs where the LUN values are not contiguous (sparse LUN).
> REPORT LUNS scanning is done only for SCSI-3 devices.

I believe my kernel has that configured. I will look when I wake. It's
530 am now, and I've been setting up my volumes for a while now. Just
about time to go to sleep, then wake up and install oracle. :)

> > > Is there a way to resolve this, either at the driver level, IMHO the
> > > place it *should* happen. At the storage level, the place that it could
> > > also happen, or in the Kernel?
> 
> This is new in 2.5.x
> 


I see. ATM I'm using 2.4.19, but would like to get to 2.4.20, because of
the TG3 fixes. 

> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
