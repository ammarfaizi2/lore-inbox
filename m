Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWEFFOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWEFFOM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 01:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWEFFOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 01:14:12 -0400
Received: from terminus.zytor.com ([192.83.249.54]:13198 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750746AbWEFFOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 01:14:12 -0400
Message-ID: <445C301E.6060509@zytor.com>
Date: Fri, 05 May 2006 22:11:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: John Coffman <johninsd@san.rr.com>
CC: Alon Bar-Lev <alon.barlev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       tony.luck@intel.com
Subject: Re: [PATCH][TAKE 4] THE LINUX/I386 BOOT PROTOCOL - Breaking    the
 256 limit
References: <445B5524.2090001@gmail.com> <445B5C92.5070401@zytor.com> <445B610A.7020009@gmail.com> <445B62AC.90600@zytor.com> <6.2.3.4.0.20060505110517.036df928@pop-server.san.rr.com> <445B96D2.9070301@zytor.com> <6.2.3.4.0.20060505144445.03642988@pop-server.san.rr.com> <445BCA33.30903@zytor.com> <6.2.3.4.0.20060505204729.036dfdf8@pop-server.san.rr.com>
In-Reply-To: <6.2.3.4.0.20060505204729.036dfdf8@pop-server.san.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Coffman wrote:
> At 02:57 PM  Friday 5/5/2006, H. Peter Anvin wrote:
> Okay, let me ask this:
> 
>> If the *kernel* limit is modified, but the LILO limit is not, what 
>> will happen?  This is the real crux of the matter.
> 
> The length of the kernel command line will be limited by the size of the 
> boot loader buffer.  LILO always inserts a NUL terminator.
> 
> --John
> 
> P.S.  The LILO command line buffer has always been 1 sector (512 bytes); 
> however, only the first half is actually used for the command line. No 
> kernel can do any harm by setting "boot_cmdline[511] = 0;" for any 
> version of LILO back to version 20 (and probably before).
> 

Okay... **DOES ANYONE HAVE ANY ACTUAL EVIDENCE TO THE CONTRARY???**, and 
if so, **WHAT ARE THE DETAILS**?

All I've heard so far is hearsay.  "X said that Y had said..."

	-hpa

