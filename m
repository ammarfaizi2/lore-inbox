Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289298AbSCOKpa>; Fri, 15 Mar 2002 05:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289556AbSCOKpL>; Fri, 15 Mar 2002 05:45:11 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:10256 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S289298AbSCOKpA>; Fri, 15 Mar 2002 05:45:00 -0500
Message-ID: <3C91D0A3.4050500@linkvest.com>
Date: Fri, 15 Mar 2002 11:44:51 +0100
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: linux-kernel@vger.kernel.org
Subject: Re: UNIX bench better on 2.2 than 2.4?
In-Reply-To: <3C91A822.7030304@linkvest.com> <20020315053211.A5619@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2002 10:44:51.0275 (UTC) FILETIME=[6F5849B0:01C1CC0E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>Results:
>>Host1: 2xPIII 550MHz / 1Gb RAM / RAID5 SCSI / 2.4.6smp + LVM
>>       Result: 164.7
>>Host2: 2xPIII 866MHz / 1Gb RAM / RAID1 soft IDE / 2.4.16smp + LVM
>>       Result: 195.7
>>Host3: 1xPIII 800MHz / 512Mb RAM / IDE / 2.2.19 RedHat 6.2
>>       Result: 208.6
>>Host4: 1xPIII 600MHz / 256Mb RAM / IDE / 2.4.19-pre2-ac4-preempt
>>       Result: 153.6
>>
>
>I dunno what Unix bench is... but isn't 153.6/208.6 close to 600/800
>in terms of a fraction?
>
Yes, you are right for this one.
But what impressed me is between Host2/Host3. One is a dual-866 with 
2.4.16 and the other is mono-800 with 2.2.19. And the host3 with 2.2.19 
is ~7% better than Host2 (Not counting that Host3 has ~8% more CPU 
clock, which should have be ~15% better for Host2 vs Host3...)

>Make Host3 or Host4 have both versions of the linux kernel in /boot
>and try each on the same machine.
>
But that's just what I'd like to see. How 2.4 compares vs 2.2
-jec


