Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSCKTFs>; Mon, 11 Mar 2002 14:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285229AbSCKTFj>; Mon, 11 Mar 2002 14:05:39 -0500
Received: from [195.63.194.11] ([195.63.194.11]:16395 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S288248AbSCKTFa>; Mon, 11 Mar 2002 14:05:30 -0500
Message-ID: <3C8CFFB8.70008@evision-ventures.com>
Date: Mon, 11 Mar 2002 20:04:24 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: arjanv@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <E16kRZp-0000or-00@the-village.bc.nu> <3C8CDA0D.7020703@evision-ventures.com> <3C8CEEFC.8137F5C0@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>And apparently we see that there is nothing special about them... Just don't
>>enable the write cache and all should be well with a timeout of 30 seconds.
>>
> 
> Quite a few controllers enable the write cache in their bootstrap before
> the OS gets involved.
> Just "don't enable" is not an option.

Right. But that can be already handled by the hdparm utility at boot.
Please note as well that the controller we are talking about
is basically the CardBus PCI-ISA bridge kind of ;-).
It doesn't do much setup. (Fingers corssed becouse I didn't
check the cs code thus far.)

