Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265871AbRF2MAk>; Fri, 29 Jun 2001 08:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbRF2MAa>; Fri, 29 Jun 2001 08:00:30 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:61163 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S265871AbRF2MAR> convert rfc822-to-8bit;
	Fri, 29 Jun 2001 08:00:17 -0400
Message-ID: <3B3C6DCB.5711888E@Sun.COM>
Date: Fri, 29 Jun 2001 13:00:11 +0100
From: Craig McLean <Craig.McLean@Sun.COM>
Reply-To: Craig.McLean@Sun.COM
Organization: Sun Microsystems
X-Mailer: Mozilla 4.76C-CCK-MCD Netscape [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: hacksaw@hacksaw.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <200106290322.EAA04600@mauve.demon.co.uk> <m2ithfr0et.fsf@mandrakesoft.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hacksaw <hacksaw@hacksaw.org> opined:
> Given that seeing as much as possible on a potentially
> small screen would be good, maybe tighter would be 
> nice. In example:
> 
> kswapd:    v1.8
> pty        Devices: 256 Unix98 ptys configured
> serial:    v5.05b (2001-05-03) with 
>            Options: MANY_PORTS SHARE_IRQ SERIAL_PCI
>            Devices: ttyS00 at 0x03f8 (irq = 4) is a 16550A
>                     ttyS01 at 0x02f8 (irq = 3) is a 16550A
> rtclock:   v1.10d
> ide:       v6.31

Perhaps a boot time option such as:

lilo boot: newkernel debug=xxxxxxx

Where each 'x' is an option given to each driver and modules as they're
loaded, say 'v' for 'show version', 'o' for 'show options', 'd' for
'show devices managed' and so on. You could even have a 'p' for 'give
mad props' if you wanted :-).
No 'debug=' could then simply cause the kernel to kprint any info from
drivers/modules that failed to load, else keep schtum.
Just my £0.02.

Craig.
--
Craig McLean				P: 01276 423905
Proactive Technical Analyst		M: 07801 459497
Sun Microsystems Proactive Services	E: craig.mclean@sun.com
