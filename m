Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318704AbSIFOfL>; Fri, 6 Sep 2002 10:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318706AbSIFOfL>; Fri, 6 Sep 2002 10:35:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:64191 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318704AbSIFOfJ>; Fri, 6 Sep 2002 10:35:09 -0400
Date: Fri, 06 Sep 2002 07:37:16 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Robert Olsson <Robert.Olsson@data.slu.se>,
       "David S. Miller" <davem@redhat.com>
cc: akpm@zip.com.au, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
Message-ID: <46676537.1031297834@[10.10.2.3]>
In-Reply-To: <15736.38178.445310.714015@robur.slu.se>
References: <15736.38178.445310.714015@robur.slu.se>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And NAPI scheme behaves different since we can not assume that all network 
> traffic is well-behaved like TCP. System has to be manageable and to "perform"
> under any network load not only for well-behaved TCP. So of course we will 
> see some differences -- there are no free lunch. Simply we can not blindly
> look at one test. IMO NAPI is the best overall performer. The number speaks 
> for themselves.

I don't doubt it's a win for most cases, we just want to reap the benefit
for the large SMP systems as well ... the fundamental mechanism seems
very scalable to me, we probably just need to do a little tuning?

> NAPI kernel path is included in 2.4.20-pre4 the comparison below is mainly 
> between e1000 driver w and w/o NAPI and the NAPI port to e1000 is still 
> evolving. 

We are running from 2.5.latest ... any updates needed for NAPI for the
driver in the current 2.5 tree, or is that OK?

Thanks,

Martin.

