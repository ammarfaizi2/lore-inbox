Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWCFXTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWCFXTn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWCFXTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:19:43 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:34478 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932447AbWCFXTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:19:42 -0500
Message-ID: <440CC332.90005@cfl.rr.com>
Date: Mon, 06 Mar 2006 18:18:10 -0500
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
X-OriginalArrivalTime: 06 Mar 2006 23:21:59.0578 (UTC) FILETIME=[C48637A0:01C64174]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14308.000
X-TM-AS-Result: No--9.700000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sending this again because it looks like the original got lost.  At 
least, I've not seen it show up on the mailing list yet and I sent it 8 
hours ago.

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


