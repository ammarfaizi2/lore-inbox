Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281778AbRKQQ6i>; Sat, 17 Nov 2001 11:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281779AbRKQQ62>; Sat, 17 Nov 2001 11:58:28 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:13295 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281778AbRKQQ6H>; Sat, 17 Nov 2001 11:58:07 -0500
Importance: Normal
Subject: [patch] scheduler cache affinity improvement in 2.4 kernels by Ingo Molnar
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF130223C2.EFFE9842-ON85256B07.0052CC33@raleigh.ibm.com>
From: "Partha Narayanan" <partha@us.ibm.com>
Date: Sat, 17 Nov 2001 10:58:05 -0600
X-MIMETrack: Serialize by Router on D04NMS38/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 11/17/2001 11:58:06 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,


The above patch for scheduler cache affinity improvement in 2.4 kernels by
Ingo Molnar was applied to 2.4.14 kernel;
a run of Volano LoopBack BenchMark on a Netfinity 8500 R 1MB 700 MHz PIII
1MB-L2 cache and 1GB memory support produced
the following results:

     The UniProcessor throughput  was reduced by 40%.
     The 4-way throughput showed a very slight degradation of 1%.
     The 8-way throughput showed an improvemnet of 10%.


I do not subscribe to lkml and hence please address any future
correspondence on this topic to partha@us.ibm.,com.

Thanks,
Partha


