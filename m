Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWEaDvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWEaDvv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 23:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbWEaDvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 23:51:51 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:54986 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751611AbWEaDvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 23:51:50 -0400
Date: Tue, 30 May 2006 21:51:47 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: cpufreq and kernel >2.6.15.6 is limited
In-reply-to: <6in4s-44o-13@gated-at.bofh.it>
To: Dave Jones <davej@redhat.com>, Eric Sandall <eric@sandall.us>,
       linux-kernel@vger.kernel.org, Mattia Dongili <malattia@linux.it>
Message-id: <447D12D3.9050306@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6imLa-3G2-11@gated-at.bofh.it> <6in4s-44o-13@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, May 30, 2006 at 05:25:26PM -0700, Eric Sandall wrote:
>  > -----BEGIN PGP SIGNED MESSAGE-----
>  > Hash: SHA1
>  > 
>  > It seems that any kernel on my Dell Inspiron 5100 after 2.6.15.6
>  > (including 2.6.17-rc5) 'breaks' my cpufreq in that up to and including
>  > 2.6.15.6 I can scale between 300MHz-2.4GHz, but after (starting with
>  > 2.6.16) I can only scale between 2.1GHz and 2.4GHz.
>  > 
>  > I've attached the files, sorted by kernel, I assume may be helpful. Let
>  > me know if you need any more.
> 
> It may have worked in the past, but the CPU has an errata which makes
> it an unsafe operation to scale below 2GHz.

There was some discussion about whether this was correct or not in this 
thread:

http://groups.google.ca/group/fa.linux.kernel/browse_thread/thread/d5b5905d7f1aa221/66c41ee3a26583b3

Did this ever get resolved? From my reading of the N60 erratum, 
disabling the 12.5% duty cycle sounds like this should be enough, 
disabling everything under 2GHz is not necessary..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

