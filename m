Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280153AbRKSRHe>; Mon, 19 Nov 2001 12:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280251AbRKSRHY>; Mon, 19 Nov 2001 12:07:24 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:28384 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S280191AbRKSRHN>;
	Mon, 19 Nov 2001 12:07:13 -0500
Importance: Normal
Subject: Re: [patch] scheduler cache affinity improvement in 2.4 kernels by Ingo
 Molnar
To: "Partha Narayanan" <partha@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF81E1FC57.F55302B5-ON85256B09.005DA446@pok.ibm.com>
From: "Shailabh Nagar" <nagar@us.ibm.com>
Date: Mon, 19 Nov 2001 12:06:52 -0500
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 11/19/2001 12:06:54 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Partha,

Sorry to see the "shoot-the-messenger" replies to your posting. I've yet to
understand why lmbench is relevant
in an SMP setting.....

Shailabh Nagar
Enterprise Linux Group, IBM TJ Watson Research Center
(914) 945 2851, T/L 862 2851


Partha Narayanan/Austin/IBM@IBMUS@vger.kernel.org on 11/17/2001 11:58:05 AM

Sent by:  linux-kernel-owner@vger.kernel.org


To:   linux-kernel@vger.kernel.org
cc:
Subject:  [patch] scheduler cache affinity improvement in 2.4 kernels by
      Ingo Molnar



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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



