Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313304AbSDHLOH>; Mon, 8 Apr 2002 07:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSDHLOG>; Mon, 8 Apr 2002 07:14:06 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:49569 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313304AbSDHLOG>; Mon, 8 Apr 2002 07:14:06 -0400
Date: Mon, 8 Apr 2002 13:00:03 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: brian@schau.dk
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.4.18 - opl3sa2 related?
In-Reply-To: <200204081016.g38AGiR22372@mail.schau.dk>
Message-ID: <Pine.LNX.4.44.0204081251410.25445-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002 brian@schau.dk wrote:

> It happens if I do a    cat /proc/ioports    after a   modprobe opl3sa2 io=0x370 mss_io=0x530 mpu_io=0x330 irq=5 dma=0 dma2=1
> 
> 
> What to do now?   Will upgrading help?

Thanks for the bugreport, be sure to CC me for opl3sa2 issues. I can check 
further and see where its dying. You can try running the latest -pre or 
newer -ac (careful about Alan's *fun* bits though ;) as that has a 
slightly updated version. I'm running 2.4.19-pre2-ac3 and can safely cat 
/proc/ioports.

Cheers,
	Zwane

-- 
http://function.linuxpower.ca
		


