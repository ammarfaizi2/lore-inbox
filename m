Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbTAGWxh>; Tue, 7 Jan 2003 17:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267552AbTAGWxg>; Tue, 7 Jan 2003 17:53:36 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:37514 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267545AbTAGWxg>;
	Tue, 7 Jan 2003 17:53:36 -0500
Message-ID: <3E1B5C44.1030302@us.ibm.com>
Date: Tue, 07 Jan 2003 15:01:24 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Andy Pfiffer <andyp@osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       suparna@in.ibm.com, Werner Almesberger <wa@almesberger.net>
Subject: Re: [PATCH] kexec for 2.5.54
References: <m1smwql3av.fsf@frodo.biederman.org>	<20021231200519.A2110@in.ibm.com> <m11y3uldt9.fsf@frodo.biederman.org>	<20030103181100.A10924@in.ibm.com>  <m1fzs6j0bh.fsf_-_@frodo.biederman.org> <1041979560.12674.93.camel@andyp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... taking poor Linus off the cc list
Andy Pfiffer wrote:
> For those that have had success w/ recent vintage kernels and kexec (>
> 2.5.48), could I get a roll-call of your machine's hardware?  Uniproc,
> SMP, AGP, chipset, BIOS version, that kind of thing.  lspci -v,
> /cat/proc/cpuinfo, and maybe the boot-up messages would all be
> appreciated.

I've had it work on 2 IBM x86 boxes.
4/8-way SMP
1/4/16 GB RAM
no AGP
Intel Profusion Chipset and some funky IBM one

It failed on the NUMA-Q's I tried it on.  I haven't investigated any 
more thoroughly.

If you want more details, let me know.  But, I've never seen your 
"Calibrating delay loop..." problem.  The last time I saw problems 
there was when I broke the interrupt stack patches.  But, since those 
aren't in mainline, you shouldn't be seeing it.
-- 
Dave Hansen
haveblue@us.ibm.com

