Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbTABJIK>; Thu, 2 Jan 2003 04:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbTABJIK>; Thu, 2 Jan 2003 04:08:10 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:44806 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP
	id <S265081AbTABJIJ>; Thu, 2 Jan 2003 04:08:09 -0500
From: Tim Connors <tconnors@astro.swin.edu.au>
Message-Id: <200301020916.h029GZV13754@hexane.ssi.swin.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: At what (Slower) CPU Speed is a Gig-E NIC pointless?
In-Reply-To: <ngurua.e49.ln@news.heiming.de>
References: <e5cbbada.0212301527.3c215ad@posting.google.com> <2Y5Q9.98900$E_.10238@news02.bloor.is.net.cable.rogers.com> <auqrbr$9bq29$2@ID-99293.news.dfncis.de> <vgtqua.i6m.ln@news.it.uc3m.es> <ngurua.e49.ln@news.heiming.de>
Date: Thu, 2 Jan 2003 20:16:35 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In comp.os.linux.networking, you wrote:
> Peter T. Breuer <ptb@oboe.it.uc3m.es> wrote:
>> William Park <opengeometry@yahoo.ca> wrote:
>>>> Keeg wrote:
>>>> 
>>>>> At what speed (and maybe other factors, like memory?) does a gigabit
>>>>> ethernet NIC card become pointless?
>>>> 
>>>> A standard PCI bus is barely able to keep up with a busy 100 Mb NIC.  It 
>>>> hasn't a hope of keeping up with Gigabit, no matter what CPU you have.
> 
>>> Wrong.  1Gigabit and 100Mbit translates to 100MB/s and 10MB/s (Byte per
>>> second), respectively, in real life.  PCI bus has 133MB/s theoretical
>>> limit, but max out at about 100MB/s in real life.
> 
>> Well, that's 32 bit, 33MHz PCI, no? I have 64 bit, 66MHz PCI myself!
>> And 2 of them per board.
> 
>> (server boards)
> 
>> I have reports of people measuring 60MB/s across GE using my ENBD
>> device. That must be on a fast bus, as the NIC and the scsi disks
>> both need that bandwidth, and both are on PCI.
> 
> The best I could get out of 64bit PCI bus, using SAN FC cards, is about
> 100 MBytes/s (rw), guess the real bottleneck are the disks, many cheapo
> IDE stuff isn't even able to cope with 100 Mb/s LAN running at full 
> speed. GB NICs only make really sense if your I/O can handle it...

Or if you are running a supercomputing centre, and the jobs your group
run are primarily CPU intensive MPI jobs rather than disk bound.


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

double value;                /* or your money back! */
short changed;               /* so triple your money back! */
             -- Larry Wall in cons.c from the perl source code
