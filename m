Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWH1Sau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWH1Sau (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWH1Sau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:30:50 -0400
Received: from terminus.zytor.com ([192.83.249.54]:16795 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750903AbWH1Sat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:30:49 -0400
Message-ID: <44F335C8.7020108@zytor.com>
Date: Mon, 28 Aug 2006 11:28:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com, Matt_Domsch@dell.com
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <445B5524.2090001@gmail.com> <200608272116.23498.ak@suse.de>	 <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de>	 <44F21122.3030505@zytor.com> <44F286E8.1000100@gmail.com>	 <44F2902B.5050304@gmail.com> <44F29BCD.3080408@zytor.com> <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com>
In-Reply-To: <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> On 8/28/06, H. Peter Anvin <hpa@zytor.com> wrote:
>> Totally pointless since we're in 16-bit mode (as is the "incl %esi")...
>> I guess it's "better" in the sense that if we run out of that we'll
>> crash due to a segment overrun... maybe (some BIOSes leave us
>> unknowningly in big real mode...)
> 
> So leave as is? Loading address into esi and reference as si?
> Or modify the whole code to use 16 bits?
> 

Probably modifying the whole code to use 16 bits, unless there is a 
specific reason not to (Matt?)

	-hpa

