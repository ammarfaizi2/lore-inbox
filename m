Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274102AbRIXSEg>; Mon, 24 Sep 2001 14:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274103AbRIXSE2>; Mon, 24 Sep 2001 14:04:28 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:46794 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274104AbRIXSDP>; Mon, 24 Sep 2001 14:03:15 -0400
Date: Mon, 24 Sep 2001 13:03:05 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <87110000.1001354585@baldur>
In-Reply-To: <46458FB0D75@vcnet.vc.cvut.cz>
In-Reply-To: <46458FB0D75@vcnet.vc.cvut.cz>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, September 24, 2001 19:52:13 +0000 Petr Vandrovec 
<VANDROVE@vc.cvut.cz> wrote:

>> > Yes, but the modules are not binary-only.
>> > The sourcecode is in the package, although it is not GPL.
>>
>> I believe they only provide source for an interface layer that can be
>> compiled against a specific version of the kernel.  I think the core
>> drivers are binary only.
>
> VMnet and VMppuser drivers are completely standalone and can work
> without VMware. You can persuade VMmon module to load and execute
> arbitrary code on kernel level - it just provides virtual machine
> environment (switches CPU context), but as it even does not link to
> anything else, I do not see any problem here. DRI drivers also allows
> you to smash arbitrary piece of memory...
>
> As for license on these modules - I was under impression that they are
> under GPL, but I'll ask VMware for clarification.

As a couple of people pointed out privately to me, I was mistaken.  VMware 
does include the complete source to its drivers.

A quick check of the file headers shows a VMware copyright with no mention 
of GPL.  Granted, that's not definitive, but it's a data point.

Dave McCracken

=====================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

