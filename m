Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUCILuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUCILuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:50:24 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:20613 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261885AbUCILuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:50:21 -0500
Date: Tue, 09 Mar 2004 19:49:37 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Kumar, Rajneesh (MED)" <rajneesh.kumar@med.ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM::  irreversible Memory growth of process in mmap()-munmap() calls 
References: <62DD37292ED5464CBB142913FC65F8AB0A59FC88@BANMLVEM01.e2k.ad.ge.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr4le4znp4evsfm@smtp.pacific.net.th>
In-Reply-To: <62DD37292ED5464CBB142913FC65F8AB0A59FC88@BANMLVEM01.e2k.ad.ge.com>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Mar 2004 14:50:35 +0530, Kumar, Rajneesh (MED) <rajneesh.kumar@med.ge.com> wrote:
> [1.] One line summary of the problem:   irreversible Memory growth of process in mmap()-munmap() calls
> 1) Linux ( Compiled with gcc 3.2.2) :  The memory size of process grows when files are mapped during first iteration of while loop. But there in no change in size after unmapping the file. However My expectations was drop in size of memory after munmap( ). On more point of interest  is  there is no
growth in memory after subsequent iterations of while loop.

Assuming you are talking about x86, gcc322 has produced the crappiest kernel code ever encountered. Even simple userspace apps got broen by it.

Suggest to change compilers to gcc295 or gcc323+ or gcc331+.

Regards
Michael
