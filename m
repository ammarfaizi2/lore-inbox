Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289033AbSAFVMB>; Sun, 6 Jan 2002 16:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289040AbSAFVL4>; Sun, 6 Jan 2002 16:11:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31757 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289063AbSAFVKj>; Sun, 6 Jan 2002 16:10:39 -0500
Message-ID: <3C38BD32.6000900@zytor.com>
Date: Sun, 06 Jan 2002 13:10:10 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Matt Dainty <matt@bodgit-n-scarper.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>	<200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>	<3C38BC6B.7090301@zytor.com> <200201062108.g06L8lM17189@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

> H. Peter Anvin writes:
> 
>>Once again, this shit does not belong in N drivers; it is core code.
>>
> 
> Drivers have to register their own device nodes. What kind of API do
> you propose?
> 


The existence of a CPU creates /dev/cpu/# and registering a node 
replicates across the /dev/cpu directories.

	-hpa


