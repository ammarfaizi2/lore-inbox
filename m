Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319050AbSHFKcS>; Tue, 6 Aug 2002 06:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319051AbSHFKcS>; Tue, 6 Aug 2002 06:32:18 -0400
Received: from sj-msg-core-4.cisco.com ([171.71.163.54]:43659 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S319050AbSHFKcR>; Tue, 6 Aug 2002 06:32:17 -0400
Message-Id: <5.1.0.14.2.20020806203012.025db940@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 06 Aug 2002 20:31:08 +1000
To: Jens Axboe <axboe@suse.de>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Linux v2.4.19-rc5
Cc: Bill Davidsen <davidsen@tmr.com>, Steven Cole <elenstev@mesatop.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>,
       Steven Cole <scole@lanl.gov>
In-Reply-To: <20020806054258.GJ3975@suse.de>
References: <Pine.LNX.3.96.1020805234423.4423A-100000@gatekeeper.tmr.com>
 <1028232945.3147.99.camel@spc9.esa.lanl.gov>
 <Pine.LNX.3.96.1020805234423.4423A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:42 AM 6/08/2002 +0200, Jens Axboe wrote:
> > Call me an optimist, but after all the reliability problems we had win the
> > 2.5 series, I sort of hoped it would be better in performance, not
> > increasingly worse. Am I misreading this? Can we fall back to the faster
> > 2.4 code :-(
>
>try a work load that excercises the block i/o layer alone (O_DIRECT,
>raw, whatnot) and then compare 2.4 and 2.5. ibm had some slides on this
>from ols, unfortunately I don't know if they have then online.

the BIO in 2.5 kicks butt over the 2.4 BIO - both in terms of increased 
throughput and decreased cpu utilization.
see some testing i previously did: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=102635456620627&w=2


cheers,

lincoln.

