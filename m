Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287289AbSASUva>; Sat, 19 Jan 2002 15:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287317AbSASUvP>; Sat, 19 Jan 2002 15:51:15 -0500
Received: from gent-smtp1.xs4all.be ([195.144.67.21]:49677 "EHLO
	gent-smtp1.xs4all.be") by vger.kernel.org with ESMTP
	id <S287289AbSASUvF>; Sat, 19 Jan 2002 15:51:05 -0500
Message-ID: <3C49EA41.6010105@xs4all.be>
Date: Sat, 19 Jan 2002 22:50:57 +0100
From: Didier Moens <moensd@xs4all.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Re: OOPS in APM 2.4.18-pre4 with i830MP agpgart
In-Reply-To: <3C487E68.1000404@xs4all.be> <3C4931DA.5020703@epfl.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Aspert wrote:

> Didier Moens wrote:
>
>> Dear all,
>>
>> On november 27th, Nicolas Aspert was so kind as to post a 
>> modification to agpgart, which catters for detection of the Intel 
>> i830MP.
>>
>> The patch was included in 2.4.18-pre2.
>>
>> Unfortunately, loading agpgart yields an oops when APM ("apm -s") is 
>> invoked, both in terminal and in X. APM functions perfectly when 
>> agpgart is absent.
>>
>>
>>
>
> Hello all
>
> Here is a patch that fixes the APM/suspend/resume issues in agpgart 
> (for 820 and 830MP chipsets).
> The patch is against 2.4.18-pre4
>
> Have a nice week-end. 


Patch functions OK for me (patch applied to 2.4.18-pre4) : I can enter 
and resume from APM with agpgart loaded.



Unfortunately, since moving from RedHat Rawhide 2.4.16-0.9 to vanilla 
2.4.18-pre4, I'm regularly confronted with the "ide_dmaproc : chipset 
supported ide_dma_lostirq func only : 13"-error when resuming from APM 
(see lkml-thread "DMA woes", 2001-12-07, with interventions from Andre 
Hedrick), but I verified this is unrelated to the presence of the 
agpgart module.


Sincerely,

Didier



