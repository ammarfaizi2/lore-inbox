Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289038AbSAFVOB>; Sun, 6 Jan 2002 16:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289035AbSAFVNp>; Sun, 6 Jan 2002 16:13:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36109 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289038AbSAFVNH>; Sun, 6 Jan 2002 16:13:07 -0500
Message-ID: <3C38BDCD.8060106@zytor.com>
Date: Sun, 06 Jan 2002 13:12:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Matt Dainty <matt@bodgit-n-scarper.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>	<200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>	<20020106204311.C2596@butterlicious.bodgit-n-scarper.com>	<3C38BCE6.3030302@zytor.com> <200201062111.g06LBjx17390@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

>>>
>>If you don't understand why this is idiotic, then let me enlighten you: 
>>there is no sensible reason why /dev/cpu/%d should only be populated 
>>after having run a CPU-dependent device driver.  /dev/cpu/%d should be 
>>always populated; heck, that's the only way you can sensibly handle 
>>hotswapping CPUs.
> 
> I've already privately told Matt that it would be nice if creation of
> /dev/cpu/%d was handled by generic boot code, and not a driver.
> However, I don't see that as essential for the CPUID and MSR drivers.
> 


I don't see putting a lot of devfs shit into the CPUID and MSR drivers 
as essential in any shape, way or form.  Do it right or don't do it at all.

	-hpa



