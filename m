Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUCJFQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 00:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUCJFQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 00:16:14 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:29346 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262006AbUCJFQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 00:16:10 -0500
Date: Wed, 10 Mar 2004 13:15:20 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Kumar, Rajneesh (MED)" <rajneesh.kumar@med.ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM::  irreversible Memory growth of process in mmap()-munmap() calls 
References: <62DD37292ED5464CBB142913FC65F8AB0A5C3B2E@BANMLVEM01.e2k.ad.ge.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr4mrjupa4evsfm@smtp.pacific.net.th>
In-Reply-To: <62DD37292ED5464CBB142913FC65F8AB0A5C3B2E@BANMLVEM01.e2k.ad.ge.com>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004 10:06:12 +0530, Kumar, Rajneesh (MED) <rajneesh.kumar@med.ge.com> wrote:

>
> The program  was originally compiled on gcc 3.3.2.  Is that a problem ?
>
>  Would appriciate your help.
>

I don't think gcc 3.3.2 has any related issue.

My reply was specifically directed at your posted which
referred gcc 3.2.2.

Regards
Michael

>
>
>
>
>
> Regards
> Rajneesh Kumar
>
> GSP, GEMS-GTO
> GE Medical Systems
> John F Welch Technology Center
> #152, EPIP. Phase 2
> Whitefield, Bangalore.560 066
>
> Ph :        (080) - 2503 3412
> Dialcom: *901 3412
> mail:       rajneesh.kumar@med.ge.com
>
>
> -----Original Message-----
> From: Michael Frank [mailto:mhf@linuxmail.org]
> Sent: Tuesday, March 09, 2004 5:20 PM
> To: Kumar, Rajneesh (MED); linux-kernel@vger.kernel.org
> Subject: Re: PROBLEM:: irreversible Memory growth of process in
> mmap()-munmap() calls
>
>
>
>
> On Tue, 9 Mar 2004 14:50:35 +0530, Kumar, Rajneesh (MED) <rajneesh.kumar@med.ge.com> wrote:
>> [1.] One line summary of the problem:   irreversible Memory growth of process in mmap()-munmap() calls
>> 1) Linux ( Compiled with gcc 3.2.2) :  The memory size of process grows when files are mapped during first iteration of while loop. But there in no change in size after unmapping the file. However My expectations was drop in size of memory after munmap( ). On more point of interest  is  there is no
> growth in memory after subsequent iterations of while loop.
>
> Assuming you are talking about x86, gcc322 has produced the crappiest kernel code ever encountered. Even simple userspace apps got broen by it.
>
> Suggest to change compilers to gcc295 or gcc323+ or gcc331+.
>
> Regards
> Michael
>
>


