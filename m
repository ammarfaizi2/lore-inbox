Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbULKRr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbULKRr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 12:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbULKRr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 12:47:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8578 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261971AbULKRrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 12:47:25 -0500
Message-ID: <41BB32A4.2090301@pobox.com>
Date: Sat, 11 Dec 2004 12:47:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rudi@asics.ws
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel (64bit) 4GB memory support
References: <1102752990.17081.160.camel@cpu0>  <41BAC68D.6050303@pobox.com> <1102760002.10824.170.camel@cpu0>
In-Reply-To: <1102760002.10824.170.camel@cpu0>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudolf Usselmann wrote:
> On Sat, 2004-12-11 at 17:06, Jeff Garzik wrote:
> 
>>Rudolf Usselmann wrote:
>>
>>>Could anybody tell me which of the previous (non 2.6.9) kernels
>>>do support 4GB of main memory in 64 bit mode ?
>>
>>64bit kernels have supported >4GB since their ports inception, AFAIK.
>>
>>Your platform could limit this artificially, of course.

> Yes, but it is currently broken (kernel panics). I wonder
> if anybody knew which kernel does work for 64 bit and >4GB
> of memory. I'm sure there must be people out there with
> similar configurations to mine ....

All 2.6 kernels work with 64bit and >4GB memory, on my configurations 
(x86-64, ia64, and alpha).

It is a mistake to assume that all 64bit and/or >4GB is broken.


> (Tiger K8W, dual Opteron)

Ok, we finally get a bit of useful information.

Are you CERTAIN that you are booting a 64bit kernel?
Is your memory PC1600, PC2100, or PC2700?
Is your memory installed in matched pairs?
Is all your memory ECC registered?
Is your BIOS at the latest version?

Once we get through the hardware issues, now it is time to do a binary 
search of 2.6 kernels, to see which one works for you.  If no 2.6 
kernels work for you, then give 2.4 kernels a try.

	Jeff


