Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSERM65>; Sat, 18 May 2002 08:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313038AbSERM64>; Sat, 18 May 2002 08:58:56 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:48628 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S312973AbSERM6z>; Sat, 18 May 2002 08:58:55 -0400
Message-ID: <3CE64D4D.4020508@notnowlewis.co.uk>
Date: Sat, 18 May 2002 13:47:09 +0100
From: mikeH <mikeH@notnowlewis.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mikeH <mikeH@notnowlewis.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.16 and VIA Chipset
In-Reply-To: <3CE629F3.5040809@notnowlewis.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apologies, on closer examination of the 2.4 and 2.5 dmesg, it hangs just 
before the
ACPI is going to come up. However, there is no option for it in make 
menuconfig, and enabling it in .config breaks the compile.

mike

mikeH wrote:

>
> I have the VIA kt266 chipset, with CONFIG_BLK_DEV_VIA82CXXX)
> it refuses to boot, hanging just before you'd expect to see the IDE
> boot messages come up.
>
> lcpsi output :
>
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
> 00:08.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
> 00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
> 00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
> 00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b)
> 00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b)
> 00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b)
> 01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 
> Ti4400] (rev a2)
>
> Is there any other info from my system that would help track down why?
>
> Thanks,
>
> mike
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>



