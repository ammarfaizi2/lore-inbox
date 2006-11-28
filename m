Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935664AbWK1GgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935664AbWK1GgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 01:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935665AbWK1GgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 01:36:24 -0500
Received: from pv105234.reshsg.uci.edu ([128.195.105.234]:41857 "HELO
	pv105234.reshsg.uci.edu") by vger.kernel.org with SMTP
	id S935664AbWK1GgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 01:36:23 -0500
Message-ID: <456BD8E4.6010003@feise.com>
Date: Mon, 27 Nov 2006 22:36:20 -0800
From: Joe Feise <jfeise@feise.com>
Reply-To: jfeise@feise.com
Organization: feise.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061025 Thunderbird/1.5.0.8 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Pauline Middelink <middelink@polyware.nl>
Subject: Re: [2.6 patch] remove the broken VIDEO_ZR36120 driver
References: <20061125191510.GB3702@stusta.de> <456BC973.1050309@feise.com> <20061128060723.GA15364@stusta.de>
In-Reply-To: <20061128060723.GA15364@stusta.de>
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote on 11/27/06 22:07:

> On Mon, Nov 27, 2006 at 09:30:27PM -0800, Joe Feise wrote:
>> Adrian Bunk wrote on 11/25/06 11:15:
>>
>>> The VIDEO_ZR36120 driver has:
>>> - already been marked as BROKEN in 2.6.0 three years ago and
>>> - is still marked as BROKEN.
>>>
>>> Drivers that had been marked as BROKEN for such a long time seem to be 
>>> unlikely to be revived in the forseeable future.
>>>
>>> But if anyone wants to ever revive this driver, the code is still 
>>> present in the older kernel releases.
>> Hmm, there are people out there (like me) who still use it and have patched it
>> to get it working on 2.6.x.
> 
> If you anyway have to patch your kernel, you can as well patch the 
> complete driver into the kernel.


Well, there are other things outside the actual driver code that may change, and
that would make it harder to keep my patch in sync.
And actually, I submitted my patch some time ago to the maintainer of the driver
(Pauline Middelink.) Unfortunately, it never made it into the kernel, nor did I
get any feedback from her. I have no idea if she is still active (she is listed
as maintainer at least until 2.6.17.) I cc'ed her on this mail.

-Joe


