Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWCFPGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWCFPGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWCFPGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:06:39 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:28766 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751384AbWCFPGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:06:38 -0500
Message-ID: <440C4F9E.6060501@cfl.rr.com>
Date: Mon, 06 Mar 2006 10:05:02 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Dan Aloni <da-x@monatomic.org>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Status of AIO
References: <20060306062402.GA25284@localdomain>
In-Reply-To: <20060306062402.GA25284@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2006 15:08:43.0561 (UTC) FILETIME=[DBEC6990:01C6412F]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14307.000
X-TM-AS-Result: No--9.700000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
> Hello,
> 
> I'm trying to assert the status of AIO under the current version 

I think you mean ascertain.

> of Linux 2.6. However by searching I wasn't able to find any 
> indication about it's current state. Is there anyone using it
> under a production environment?
> 
> I'd like to know how complete it is and whether socket AIO is
> adaquately supported.
> 
> Thanks,
> 

AFAIK, it is not yet supported by the sockets layer, and the glibc posix 
aio apis do NOT use the kernel aio support.  I have done some 
experimentation with it by hacking dd, but from what I can tell, it is 
not used in any sort of production capacity.

