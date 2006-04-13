Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWDMXA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWDMXA7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWDMXA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:00:58 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:47835 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751173AbWDMXA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:00:58 -0400
Message-ID: <443EE3AF.7020604@wolfmountaingroup.com>
Date: Thu, 13 Apr 2006 17:50:07 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, K P <kplkml@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: JVM performance on Linux (vs. Solaris/Windows)
References: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com>  <443E74C1.5090801@mbligh.org> <443EBC1D.1000307@wolfmountaingroup.com> <Pine.LNX.4.62.0604131220560.15794@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0604131220560.15794@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

> On Thu, 13 Apr 2006, Jeff V. Merkey wrote:
>
>> Note they ran the benchmark on an Opteron 285 instead of a Xeon with 
>> 16 GB of memory. Opteron peformance currently **SUCKS** with 2.6 
>> series kernels under any kind of heavy I/O due to their cloning of 
>> the ancient 82489DX architecture for I/O interrupt access and 
>> performance. Looks like the test was stakced against Linux from the 
>> start. Should have used a Xeon system. AMD needs to get their crappy 
>> I/O performance up to snuff. Looking at the test parameteres leads me 
>> to believe there was a lot of swapping on a system with already poor 
>> I/O performance.
>
>
> Jeff, I've seen several reccomendations from databasefolks (postgres 
> and mysql) favoring Opterons over Xeons. this doesn't match your 
> statement that Opteron performance sucks under any kind of I/O load. I 
> don't understand how both can be correct.
>
> David Lang
>
Hi David,

I have tested our Solera products on both Xeon and Opteron Processors. I 
can sustain 500 MB/S capture off the wire on 4 x 1000 Gigabit segments
due to the incredible performance of Xeon based I/O chipsets. My tests 
with Opteron based systems are sick in comparison. An Opteron 200 series 
CPU on a Tyan based motherbord system is discouraging on comparison. The 
Opteron systems will only sustain 150 MB/S with the same software.

The I/O chipset performance for disk and LAN I/O is purtrid compared to 
the 7500 series I/O chipsets.

Jeff

