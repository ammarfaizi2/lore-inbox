Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262494AbSJGQx0>; Mon, 7 Oct 2002 12:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262544AbSJGQx0>; Mon, 7 Oct 2002 12:53:26 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:11766 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262494AbSJGQxZ>; Mon, 7 Oct 2002 12:53:25 -0400
Message-ID: <3DA1BD51.6040003@us.ibm.com>
Date: Mon, 07 Oct 2002 09:58:57 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] HZ as a config option
References: <3D9E1BEA.7060804@us.ibm.com> <1033779196.1335.8.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Fri, 2002-10-04 at 23:53, Dave Hansen wrote:
> 
>>On large systems (like NUMA-Q, Intel Profusion, etc...), latency and 
>>user responsiveness become much less important.  The extra scheduling 
>>overhead caused by higher HZ is bad.
>>
>>This is x86-only right now.  Is there any wider desire to tune this at 
>>config time?  Do any architecutures have strict rules as to what this 
>>can be set to?
> 
> You can't set this arbitarily, the NTP PLL's will only lock for certain
> value ranges.

Where can I find these ranges?  include/linux/timex.h only errors if 
the number is out of the 12-1535 range.

-- 
Dave Hansen
haveblue@us.ibm.com

