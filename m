Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTAVVFF>; Wed, 22 Jan 2003 16:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbTAVVFF>; Wed, 22 Jan 2003 16:05:05 -0500
Received: from vsmtp2.tin.it ([212.216.176.222]:21408 "EHLO smtp2.cp.tin.it")
	by vger.kernel.org with ESMTP id <S263321AbTAVVFC>;
	Wed, 22 Jan 2003 16:05:02 -0500
Message-ID: <3E2F0A20.20603@tin.it>
Date: Wed, 22 Jan 2003 22:16:16 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: vph@iki.fi
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
References: <3E2C8EFF.6020707@tin.it> <3E2C9623.60709@sktc.net> <3E2CD91B.2080305@tupshin.com> <20030122200630.GA17220@vph.iki.fi>
In-Reply-To: <20030122200630.GA17220@vph.iki.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Hallivuori wrote:

>>I wouldn't necessarily assume a hardware problem (unless we also include 
>>chipset oddities). I get *exactly* one message stating exactly this per 
>>boot, and it always come a few seconds after loading the parport and 
>>parport_pc modules.
>>    
>>
>
>  
>
>>Jan 20 09:20:07 testing kernel: spurious 8259A interrupt: IRQ7.
>>    
>>
>
>I also see this message on every boot... I have two Soyo
>SY-KT400 Dragon Ultra mother boards, and the message appears with both
>of them. Perhaps it is some VIA oddity?. Anyhow, it does not seem to
>have any harmful effects (both boards are rock solid with 2.4.20).
>
>Dec 23 20:34:37 mood kernel: Real Time Clock Driver v1.10e
>Dec 23 20:34:37 mood kernel: spurious 8259A interrupt: IRQ7.
>
>
>  
>
When I enable I/O APIC the problem disappear , it is present only if I 
enable Local APIC. There is a possibility that that IRQ is an IRQ of I/O 
APIC , and when it is disabled it isn't initialized with Local APIC only 
. In this case the message can be ignored without any preoccupations

Bye

Marcello

