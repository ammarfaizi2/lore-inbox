Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTE2WrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 18:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTE2WrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 18:47:03 -0400
Received: from miranda.zianet.com ([216.234.192.169]:64268 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S263126AbTE2Wq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 18:46:57 -0400
Message-ID: <3ED690FE.5080602@zianet.com>
Date: Thu, 29 May 2003 17:00:14 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Duncan Laurie <duncan@sun.com>
CC: Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
References: <20030529114001.GD7217@louise.pinerecords.com> <oprpygljynury4o7@lists.bilicki.com>
In-Reply-To: <oprpygljynury4o7@lists.bilicki.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is mine which doesn't work.

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00: 66 11 01 02 47 00 00 22 93 00 01 06 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 01 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 06 1e 0c 03 00 00 00 07 0f 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 8f c3 d1 15 00 00 00 20 00 00 00 00
70: 0f 00 00 00 00 00 00 00 80 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 01 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: a1 0e 00 00 80 00 5d 0f ff 0f 04 10 01 aa 00 ac
b0: 00 07 1c 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 03 58 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00: 66 11 12 02 45 01 00 02 93 82 01 01 08 40 80 00
10: f1 01 00 00 f5 03 00 00 01 00 00 00 01 00 00 00
20: 01 20 00 00 00 00 00 00 00 00 00 00 66 11 12 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 5d 20 5d 5d ff 00 ff ff 00 01 04 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 0f 04 03 00 00 00 00 00
60: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Steve

Duncan Laurie wrote:

> On Thu, 29 May 2003 13:40:01 +0200, Tomas Szepe 
> <szepe@pinerecords.com> wrote:
>
>>
>> I can't seem to get the onboard Serverworks CSB5 IDE controller (rev 93)
>> in a Compaq Proliant ML350 G3 to work (reliably/at all) no matter what
>> kernel I use:
>>
>
> Hi Tomas,
>
> This problem *may* actually be in the hardware...  IIRC the CSB5 rev 
> 93h is
> the A2.1 version of the chip which had big problems with DMA.  The 
> workaround
> options included a messy rework of the PCB or forcing it into PIO 
> mode, so we
> decided instead to just stick with the A2.0 revision. :)
>
> However all of my knowledge about this particular issue is based on 
> >1yr old
> information, so if you want to send the output of "lspci -xxx" for pci 
> devices
> 00:0f.0 and 00:0f.1 I will check them over for any obvious settings 
> the BIOS
> may have missed.
>
> -duncan
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


