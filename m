Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRKNXUb>; Wed, 14 Nov 2001 18:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277431AbRKNXUW>; Wed, 14 Nov 2001 18:20:22 -0500
Received: from 216-175-173-2.client.dsl.net ([216.175.173.2]:13300 "HELO
	mail.fdfl") by vger.kernel.org with SMTP id <S276591AbRKNXUH>;
	Wed, 14 Nov 2001 18:20:07 -0500
Message-ID: <3BF2FC25.2040108@frontierd-us.com>
Date: Wed, 14 Nov 2001 18:20:05 -0500
From: Jelle Foks <jelle@frontierd-us.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011014
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dmitri Pogosyan <pogosyan@Phys.UAlberta.CA>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What Athlon chipset is most stable in Linux with 3 512MB DDR modules ?
In-Reply-To: <Pine.LNX.4.30.0111141509530.879-100000@thorne>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitri Pogosyan wrote:

>Since there is discussion of Athlon chipsets (and mainboards) and memory
>is mentioned, could anybody advice me what chipset (or motherboard)
>reliably supports 3 512 MB DDR modules (registered or unregistered, does
>not matter) ?  I need as much memory as  possible :).
>
I have a XP1800+ in a Shuttle AK31 rev 3.1 board (KT266A chipset) with 4 
Kingston non-ecc non-registered 512MB PC2100 (Infineon chips) modules 
running, working with all 2GB correctly with no errors on a 100+ hours 
run of memtest86 v2.7 (www.memtest86.com). The disadvantage is that it 
needs the BIOS RAM settings at almost the slowest (2T command rate) to pass.

Also, I have another of the same configuration, but with 4 ECC Kingston 
512MB PC2100, and that system passed a 10hour memtest86 2.7 run (did not 
try longer), albeit also only with the slow RAM settings.

Both systems are happily running Linux 2.4.9 and 2.4.14

Cya,

Jelle.

>
>People at the shop tried to put together for me  MSI KT266 Pro2
>(Via KT266a chipset) with XP 1800+ Athlon and  1.5  GB memory in 3 512
>Mb modules (unregistered, non ECC, probably by Kingston) and this
>configuration to pass memory stress tests they run  (BIOS detects
>1.5 Gb all right, and individual modules pass the test when used one by
>one in any of 3 slots).
>
>Also I heard AMD761 also had problems with 3 high memory sticks, although
>maybe not with registered one. (One mail order place refused to sell me
>512 unregistered memory when I said I'll use it in Gigabyte motherboard
>saying it will not work).
>
>I'm not sure Via KT266a supports registered memory, does it ?  Manual to
>MSI motherboard says  'unbuffered memory' support,   but on the memory
>test site from MSI there are examples
>of registered modules they run, albeight only 3x 256 MB
>
>
>	Thanks in advance for advice, Dmitri
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



