Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264513AbSIQUpE>; Tue, 17 Sep 2002 16:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264520AbSIQUpE>; Tue, 17 Sep 2002 16:45:04 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:41093 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264513AbSIQUpC>;
	Tue, 17 Sep 2002 16:45:02 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Lse-tech] Hyperthreading performance on 2.4.19 and 2.5.32
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFC9812D06.E7590486-ON85256C37.00713B16@pok.ibm.com>
From: "Duc Vianney" <dvianney@us.ibm.com>
Date: Tue, 17 Sep 2002 15:49:45 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 09/17/2002 04:49:47 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>What happened to the -38% degradation you found? That seems to have
>fallen off the results list for some reason ... did you fix it, or is it
still >there?

Martin ... Thanks for pointing it out.
The -38% degradation was seen on Sync Random Disk Writes, Sync
Sequential Disk Writes, and Sync Disk Copies observed from the
AIM9 bencmark running in Single User test mode. The degradation
is still there and I will investigate it later when we have the
hardware resource back.

Thanks ... Duc.



"Martin J. Bligh" <mbligh@aracnet.com>@lists.sourceforge.net on 09/17/2002
03:05:35 PM

Sent by:    lse-tech-admin@lists.sourceforge.net


To:    Duc Vianney/Austin/IBM@IBMUS, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
cc:
Subject:    Re: [Lse-tech] Hyperthreading performance on 2.4.19 and 2.5.32



> Benchmarks. For multithreaded benchmarks: chat, dbench and tbench.
> Summary of results. The results on Linux kernel 2.4.19 show HT might
> improve multithreaded application by as much as 30%. On kernel 2.5.32,
> HT may provide speed-up as high as 60%.

What happened to the -38% degradation you found? That seems to have
fallen off the results list for some reason ... did you fix it, or is it
still there?

M.




-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
 https://lists.sourceforge.net/lists/listinfo/lse-tech




