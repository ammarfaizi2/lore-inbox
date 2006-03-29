Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWC2Ud5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWC2Ud5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 15:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWC2Ud5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 15:33:57 -0500
Received: from ws6-6.us4.outblaze.com ([205.158.62.64]:64657 "HELO
	ws6-6.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750839AbWC2Ud4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 15:33:56 -0500
Message-ID: <442AEF2B.2000506@daxsolutions.com>
Date: Wed, 29 Mar 2006 12:33:47 -0800
From: Paul Risenhoover <prisenhoover@daxsolutions.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jussi Hamalainen <count@theblah.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel: BUG: soft lockup detected on CPU#0!
References: <4429A027.1010509@daxsolutions.com> <Pine.LNX.4.62.0603290748240.22034@mir.senvnet.fi>
In-Reply-To: <Pine.LNX.4.62.0603290748240.22034@mir.senvnet.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the info Jussi, and I will definitely try that, but I don't 
understand why the stack trace shows a pile of smbfs calls, and how that 
might relate to the USB controller.  But then again, maybe that's why 
I'm not a kernel developer.

Jussi Hamalainen wrote:

> On Tue, 28 Mar 2006, Paul Risenhoover wrote:
>
>> I have been experiencing a number of networking issues with three new 
>> machines I have purchased.  They are Dell SC1425 machines, each with 
>> two 64-bit processors.  I have attached the dmesg log to this email 
>> for your review.
>
>
> Although not it is possibly not directly related to your problem, I've 
> also experienced soft lockups on CPU#0 with a Dell PE1850 running
> Xen unstable and 2.6.16. The BUG caused the machine to instantly crash 
> and was 100% reproducible by starting an ftp transfer from
> a fast server.
>
> After spending a good portion of the day pulling my hair out, I 
> figured out that the USB controller in Dell PowerEdges is really flaky 
> and had caused similar problems before. Disabling the USB controller 
> from BIOS made my problem go away.
>


-- 
____
This email message is for the sole use of the intended recipient(s) and may contain confidential and privileged information. Any unauthorized review, use, disclosure or distribution is prohibited. If you are not the intended recipient, please contact the sender by reply email and destroy all copies of the original message.

