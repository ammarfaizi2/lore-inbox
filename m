Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbUCDNF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbUCDNF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:05:58 -0500
Received: from mail.timesys.com ([65.117.135.102]:57237 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261878AbUCDNFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:05:49 -0500
Message-ID: <404729AC.8010405@timesys.com>
Date: Thu, 04 Mar 2004 08:05:48 -0500
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH} PPC 32 multithreaded core dumps
References: <403D04D4.3020502@timesys.com> <20040225211353.GD1052@smtp.west.cox.net>
In-Reply-To: <20040225211353.GD1052@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2004 12:58:09.0828 (UTC) FILETIME=[58469E40:01C401E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:

>On Wed, Feb 25, 2004 at 03:25:56PM -0500, Greg Weeks wrote:
>
>  
>
>>This code fixes the register dumps for 32 bit ppc multi threaded core 
>>dumps. It's largely based on the ppc64 code. It was tested on an 8260 
>>    
>>
>
>This looks right, and I'll think about it a bit more and apply.
>
>  
>
>>processor with the TimeSys modified 2.6.1 kernel. The patch is for 
>>2.6.3. Let me know if there are any problems with it. If anyone can tell 
>>me why arch/ppc/boot/simple/misc.c was including elf.h in the first 
>>place I'd appreciate it. It doesn't appear to need it and it doesn't 
>>like task_struct now.
>>    
>>
>
>Long ago it used to care more about the file it was dealing with.  I'll
>remove it from the other files in boot/ that include it as well.
>
>  
>
How does this still look?

Greg W
