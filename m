Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288979AbSANTRx>; Mon, 14 Jan 2002 14:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSANTQh>; Mon, 14 Jan 2002 14:16:37 -0500
Received: from vsdc01.corp.publichost.com ([64.7.196.123]:52749 "EHLO
	vsdc01.corp.publichost.com") by vger.kernel.org with ESMTP
	id <S288969AbSANTQI>; Mon, 14 Jan 2002 14:16:08 -0500
Message-ID: <3C432E72.3020608@vitalstream.com>
Date: Mon, 14 Jan 2002 11:16:02 -0800
From: Rick Stevens <rstevens@vitalstream.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <87k7ukyjme.fsf@fadata.bg> <20020114030925.A1363@viejo.fsmlabs.com> <E16QC5P-0000nO-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> On January 14, 2002 10:09 am, yodaiken@fsmlabs.com wrote:
> 
>>UNIX generally tries to ensure liveness. So you know that
>>	cat lkarchive | grep feel | wc
>>will complete and not just that, it will run pretty reasonably because
>>for UNIX _every_ process is important and gets cpu and IO time.
>>When you start trying to add special low latency tasks, you endanger
>>liveness.  And preempt is especially corrosive because one of the 
>>mechanisms UNIX uses to assure liveness is to make sure that once a 
>>process starts it can do a significant chunk of work.
>>
> 
> You're claiming that preemption by nature is not Unix-like?


Unix started out life as a _time-sharing_ OS.  It never claimed to
be preemptive or real time.  For those, you waited a while, then
got to run MACH.
----------------------------------------------------------------------
- Rick Stevens, SSE, VitalStream, Inc.      rstevens@vitalstream.com -
- 949-743-2010 (Voice)                    http://www.vitalstream.com -
-                                                                    -
-        Change is inevitable, except from a vending machine.        -
----------------------------------------------------------------------

