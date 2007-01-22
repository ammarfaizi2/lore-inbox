Return-Path: <linux-kernel-owner+w=401wt.eu-S1751057AbXAVIHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbXAVIHk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 03:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbXAVIHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 03:07:40 -0500
Received: from server077.de-nserver.de ([62.27.12.245]:55040 "EHLO
	server077.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbXAVIHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 03:07:40 -0500
Message-ID: <45B470BB.8000208@profihost.com>
Date: Mon, 22 Jan 2007 09:07:23 +0100
From: Stefan Priebe - FH <studium@profihost.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: XFS or Kernel Problem / Bug
References: <20060801143212.D2326184@wobbly.melbourne.sgi.com> <44CEDA1D.5060607@profihost.com> <20060801143803.E2326184@wobbly.melbourne.sgi.com> <44CF36FB.6070606@profihost.com> <20060802090915.C2344877@wobbly.melbourne.sgi.com> <44D07AB7.3020409@profihost.com> <20060802201805.A2360409@wobbly.melbourne.sgi.com> <45B35CD7.4080801@profihost.com> <20070122061852.GT33919298@melbourne.sgi.com> <45B46CEE.4090808@profihost.com> <20070122080306.GW33919298@melbourne.sgi.com>
In-Reply-To: <20070122080306.GW33919298@melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 84.134.23.182
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The update of the IDE layer was in 2.6.19. I don't think it is a 
hardware bug cause all these 5 machines runs fine since a few years with 
2.6.16.X and before. We switch to 2.6.18.6 on monday last week and all 
machines began to crash periodically. On friday last week we downgraded 
them all to 2.6.16.37 and all 5 machines runs fine again. So i don't 
believe it is a hardware problem. Do you really think that could be?

Stefan

David Chinner schrieb:
> On Mon, Jan 22, 2007 at 08:51:10AM +0100, Stefan Priebe - FH wrote:
>> Hi!
>>
>> I'm  not shure but perhaps it isn't an XFS Bug.
>>
>> Here is what i find out:
>>
>> We've about 300 servers at the momentan and 5 of them are "old" Intel 
>> Pentium 4 Machines with a DFI PM-12 Mainboard with VIA chipset. It only 
>> happens on THESE Machines.
> 
> Hmmm - that points more to a hardware problem than a software problem;
> crashes in generic_file_buffered_write() are relatively uncommon, and
> to have them all isolated to a specific type of hardware is suspicious....
> 
> Wasn't there a major update of the IDE layer in 2.6.18? or was that
> 2.6.19 that I'm thinking of? BTW, have you run memtest86 on these
> boxes to rule out dodgy memory?
> 
> Cheers,
> 
> Dave.

