Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266442AbTGJUbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266450AbTGJUbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:31:20 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:51446 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S266442AbTGJUbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:31:18 -0400
Message-ID: <3F0DD05B.3030607@mvista.com>
Date: Thu, 10 Jul 2003 13:45:15 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patch
 attached to fix
References: <Pine.SOL.4.30.0307102202340.22284-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0307102202340.22284-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the kernel with the special fasttrak feature enabled, and it 
didn't work.  There are special cases in the pci-setup.c code for other 
promise adaptors, so adding one more seems to make sense.

Thanks
-steve

Bartlomiej Zolnierkiewicz wrote:

>Hi,
>
>Do you have "Special FastTrak Feature" enabled?
>
>--
>Bartlomiej
>
>On Thu, 10 Jul 2003, Steven Dake wrote:
>
>  
>
>>Folks,
>>
>>After I upgraded to 2.4.21, I noticed my Gigabyte motherboard with
>>onboard IDE Promise 20276 FastTrack RAID no longer works.  The following
>>patch fixes the problem, which appears to be an incomplete list of
>>devices in the ide setup code.  There are probably other fasttrack RAID
>>adaptors that should be added to the setup code, but I don't know what
>>they are.
>>
>>Thanks
>>-steve
>>    
>>
>
>
>
>  
>

