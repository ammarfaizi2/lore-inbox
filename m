Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282896AbRLDBwE>; Mon, 3 Dec 2001 20:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282187AbRLDBuZ>; Mon, 3 Dec 2001 20:50:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:3456 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S282163AbRLDBtq>;
	Mon, 3 Dec 2001 20:49:46 -0500
Date: Mon, 03 Dec 2001 17:49:33 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <2379426132.1007401773@mbligh.des.sequent.com>
In-Reply-To: <3C0A9BD7.47473324@zip.com.au>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Really?  So then people should be designing for 128 CPU machines, right?
> 
> Linux only supports 99 CPUs.  At 100, "ksoftirqd_CPU100" overflows
> task_struct.comm[].
> 
> Just thought I'd sneak in that helpful observation.

For machines that are 99bit architectures or more, maybe. For 32 bit machines,
your limit is 32, for 64 bit, 64.

M.

