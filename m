Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280917AbRKGT0S>; Wed, 7 Nov 2001 14:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280928AbRKGT0L>; Wed, 7 Nov 2001 14:26:11 -0500
Received: from vp226158.uac62.hknet.com ([202.71.226.158]:32522 "EHLO
	main.coppice.org") by vger.kernel.org with ESMTP id <S280937AbRKGTZz>;
	Wed, 7 Nov 2001 14:25:55 -0500
Message-ID: <3BE98BA9.7090102@coppice.org>
Date: Thu, 08 Nov 2001 03:29:45 +0800
From: Steve Underwood <steveu@coppice.org>
Organization: Me? Organised?
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en, zh-TW
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kermel ML <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686 timer bugfix incomplete
In-Reply-To: <E161RcS-0003x8-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>but it seems that the patch was incomplete: The bug is still triggered on my
>>computer using 2.4.14, but the bugfix seems to work whith -ac kernels.
>>
> 
> The first piece is in.
> 
> 
>>you can see what's missing to actually work around the via timer bug. I hope
>>this will go into 2.4.15.
>>
> 
> I don't plan to submit it until the locking fixes for the timer access are
> done and we know the real cause


If the messages:

probable hardware bug: clock timer configuration lost - probably a 
VIA686a motherboard.
probable hardware bug: restoring chip configuration.

are really related to a VIA686A bug, why do they erratically appear on 
Compaq ML370's, which use ServerWorks chip sets? Is there a common bug 
between these chip sets? Seems unlikely.

Regards,
Steve



