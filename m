Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbREQAUW>; Wed, 16 May 2001 20:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261350AbREQAUQ>; Wed, 16 May 2001 20:20:16 -0400
Received: from [24.93.67.55] ([24.93.67.55]:32783 "EHLO mail8.carolina.rr.com")
	by vger.kernel.org with ESMTP id <S261346AbREQAT7>;
	Wed, 16 May 2001 20:19:59 -0400
From: Zilvinas Valinskas <zvalinskas@carolina.rr.com>
Date: Wed, 16 May 2001 20:19:26 -0400
To: Jussi Laako <jlaako@pp.htv.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA/PDC/Athlon
Message-ID: <20010516201926.A909@clt88-175-140.carolina.rr.com>
In-Reply-To: <3B02B824.6FAF5125@pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B02B824.6FAF5125@pp.htv.fi>; from jlaako@pp.htv.fi on Wed, May 16, 2001 at 08:25:56PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 08:25:56PM +0300, Jussi Laako wrote:
> I tested 2.4.4-ac9 today on A7V133 machine. It booted up, but can't stand
> any load. It will deadlock (without oops) when the network/disk system faces
> any load.
> 
reset/clear CMOS with jumper. I get this kind of instability each time
I have to boot to win9x (with latest and greatest via drivers) and back
to linux. Just of sudden linux freezes or if I have apcid running 
sometimes it oops' on boot sometimes later ... lots of defunc  kacpid ...
threads.

looks like VIA drivers do something to hardware (or maybe only ACPI part
of hardware ... I don't know.) and linux can't handle hardware is this
new "after win9x" state ... 

reset/clear CMOS with jumper helped. 

MB ABit KT7A-RAID

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)

VT82C686b actually :)


00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:08.0 Ethernet controller: Bridgecom, Inc: Unknown device 0985 (rev 11)
00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
00:0f.1 Input device controller: Creative Labs SB Live! (rev 07)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5144


> 
>  - Jussi Laako
> 
> -- 
> PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
> Available at PGP keyservers
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Zilvinas Valinskas
