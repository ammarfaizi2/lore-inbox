Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbTBOSij>; Sat, 15 Feb 2003 13:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbTBOSij>; Sat, 15 Feb 2003 13:38:39 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:43700 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264883AbTBOSii>;
	Sat, 15 Feb 2003 13:38:38 -0500
Message-ID: <3E4E8B41.6080609@us.ibm.com>
Date: Sat, 15 Feb 2003 10:47:29 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with 2.5.61-mm1
References: <3E4E0153.3000008@us.ibm.com> <92090000.1045333203@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> No, that's a kirq broke no_irq_balance thing (I presume this is NUMA-Q?).

Nope, it's an 8-way Summit box.

I just booted 2.5.61, and the problem still happens there, so it not
surprisingly isn't just -mm.

> There's a bootflag option to disable it as well, but that's broken too. I
> can't fix do it right now, but someone needs to go through and fix all the
> disable bits so they work.

Disabling it is easy.  Any idea what might be wrong.

-- 
Dave Hansen
haveblue@us.ibm.com

