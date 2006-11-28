Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936035AbWK1TLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936035AbWK1TLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936037AbWK1TLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:11:40 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:8576 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP id S936035AbWK1TLj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:11:39 -0500
Message-ID: <456C89E7.9010507@web.de>
Date: Tue, 28 Nov 2006 20:11:35 +0100
From: Peter Schlaf <peter.schlaf@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8.0.8) Gecko/20060911 SUSE/1.0.6-0.1 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Pauline Middelink <middelink@polyware.nl>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] remove the broken VIDEO_ZR36120 driver
References: <20061125191510.GB3702@stusta.de> <456BC973.1050309@feise.com>	<20061128060723.GA15364@stusta.de>  <456BD8E4.6010003@feise.com> <1164707859.12613.7.camel@localhost>
In-Reply-To: <1164707859.12613.7.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab schrieb:
> Hi Joe,
> 
> Em Seg, 2006-11-27 às 22:36 -0800, Joe Feise escreveu:
>> Adrian Bunk wrote on 11/27/06 22:07:
>>
>>> On Mon, Nov 27, 2006 at 09:30:27PM -0800, Joe Feise wrote:
>>>> Adrian Bunk wrote on 11/25/06 11:15:
>>>>
>>>>> But if anyone wants to ever revive this driver, the code is still 
>>>>> present in the older kernel releases.
>>>> Hmm, there are people out there (like me) who still use it and have patched it
>>>> to get it working on 2.6.x.
>>> If you anyway have to patch your kernel, you can as well patch the 
>>> complete driver into the kernel.
>> Well, there are other things outside the actual driver code that may change, and
>> that would make it harder to keep my patch in sync.
> Keeping it in sync is not hard. Most changes are just small API changes
> that are easy to port to all drivers, since they all behave likely.
> Also, when kernel hackers changes API, they usually send patches fixing
> API also at the affected drivers (of course for not-broken stuff).
>> And actually, I submitted my patch some time ago to the maintainer of the driver
>> (Pauline Middelink.)  Unfortunately, it never made it into the kernel, nor did I
>> get any feedback from her. I have no idea if she is still active (she is listed
>> as maintainer at least until 2.6.17.) I cc'ed her on this mail.
> If you are interested on fixing this driver, you may submit the fix
> patch to me, with your SOB. I'm maintaining the V4L subsystem as a hole.
>>
>> -Joe
>>
>>
> Cheers, 
> Mauro.

Hello,

I would like to see this driver fixed and remaining in the kernel and
would give any support I can to achive this goal.

I have a zr36120 based tv card and wrote a driver on my own based on
this kernel driver from Pauline Middelink. Maybe it could be helpful.

CU
Peter
