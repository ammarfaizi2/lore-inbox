Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbUJYPcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbUJYPcF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbUJYP25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:28:57 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:24525 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261960AbUJYP20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:28:26 -0400
Message-ID: <417D1B8D.3000709@nortelnetworks.com>
Date: Mon, 25 Oct 2004 09:28:13 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, "Jack O'Quin" <joq@io.com>
Subject: Re: How is user space notified of CPU speed changes?
References: <1098399709.4131.23.camel@krustophenia.net>	 <1098444170.19459.7.camel@localhost.localdomain>	 <1098468316.5580.18.camel@krustophenia.net>	 <4179623C.9050807@nortelnetworks.com> <1098487558.1440.20.camel@krustophenia.net>
In-Reply-To: <1098487558.1440.20.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2004-10-22 at 13:40 -0600, Chris Friesen wrote:
>>x86 really could use an on-die register that increments at 1GHz independent of 
>>clock speed and is synchronized across all CPUs in an SMP box.
> 
> 
> Like this? (posted to jackit-devel):
> 
> On Fri, 2004-10-22 at 18:20 -0500, Jack O'Quin wrote: 
>>On PowerPC, JACK uses the lower half of the 64-bit Timebase register,
>>which is accessible from user mode.  This is better then the i386
>>cycle counter, I believe.

Yes, ppc tbr is nice.  It's actually lower resolution than the x86 one, but it 
might be better for smp and freq changes--not sure.

Chris
