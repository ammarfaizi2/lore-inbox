Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRBIVdj>; Fri, 9 Feb 2001 16:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129576AbRBIVda>; Fri, 9 Feb 2001 16:33:30 -0500
Received: from [64.64.109.142] ([64.64.109.142]:48644 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129564AbRBIVdR>; Fri, 9 Feb 2001 16:33:17 -0500
Message-ID: <3A8461D0.1543EC4@didntduck.org>
Date: Fri, 09 Feb 2001 16:32:00 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ashish Gupta <gashish@cse.iitk.ac.in>
CC: kernelnewbies@humbolt.nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: problem in BOGOmips
In-Reply-To: <Pine.LNX.4.04.10102100210150.12228-100000@csews12.cse.iitk.ac.in>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashish Gupta wrote:
> 
> Hi,
>         I want to use bogomips as the indicator of CPU capability for
> different architectures. I have found following values from /proc/cpuinfo
> for different CPUs.
> 
>         MHz             bogomips version
>         233 intel       233      2.2.9, 2.0.36
>         166 intel       331      2.2.9
>         450 AMD-K6      900      2.2.14
>         800 intel       1600     2.2.16
> 
> Why there is a exceptional behaviour of bogomips for 233 intel ?
> If there is some patch or changes then please indicate so that i can use
> it.
> 
> Thanks in advance
> Ashish Gupta

Bogomips are simply a timing delay loop factor.  They do not reflect CPU
performance at all.  Bogomips is short for bogus mips.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
