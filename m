Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUCJEgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 23:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCJEgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 23:36:25 -0500
Received: from ext-ch1gw-3.online-age.net ([216.34.191.37]:1699 "EHLO
	ext-ch1gw-3.online-age.net") by vger.kernel.org with ESMTP
	id S261939AbUCJEgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 23:36:23 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6521.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: PROBLEM::  irreversible Memory growth of process in mmap()-munmap() calls 
Date: Wed, 10 Mar 2004 10:06:12 +0530
Message-ID: <62DD37292ED5464CBB142913FC65F8AB0A5C3B2E@BANMLVEM01.e2k.ad.ge.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM::  irreversible Memory growth of process in mmap()-munmap() calls 
Thread-Index: AcQF22J/c7dRuVQMQviHPHLb+CwLPgAfxXTw
From: "Kumar, Rajneesh \(MED\)" <rajneesh.kumar@med.ge.com>
To: "Michael Frank" <mhf@linuxmail.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Mar 2004 04:36:17.0711 (UTC) FILETIME=[3A88B3F0:01C40659]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The program  was originally compiled on gcc 3.3.2.  Is that a problem ?

 Would appriciate your help.






Regards
Rajneesh Kumar

GSP, GEMS-GTO
GE Medical Systems
John F Welch Technology Center
#152, EPIP. Phase 2
Whitefield, Bangalore.560 066

Ph :        (080) - 2503 3412
Dialcom: *901 3412
mail:       rajneesh.kumar@med.ge.com


-----Original Message-----
From: Michael Frank [mailto:mhf@linuxmail.org]
Sent: Tuesday, March 09, 2004 5:20 PM
To: Kumar, Rajneesh (MED); linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:: irreversible Memory growth of process in
mmap()-munmap() calls 




On Tue, 9 Mar 2004 14:50:35 +0530, Kumar, Rajneesh (MED) <rajneesh.kumar@med.ge.com> wrote:
> [1.] One line summary of the problem:   irreversible Memory growth of process in mmap()-munmap() calls
> 1) Linux ( Compiled with gcc 3.2.2) :  The memory size of process grows when files are mapped during first iteration of while loop. But there in no change in size after unmapping the file. However My expectations was drop in size of memory after munmap( ). On more point of interest  is  there is no
growth in memory after subsequent iterations of while loop.

Assuming you are talking about x86, gcc322 has produced the crappiest kernel code ever encountered. Even simple userspace apps got broen by it.

Suggest to change compilers to gcc295 or gcc323+ or gcc331+.

Regards
Michael
