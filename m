Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288040AbSAUUG6>; Mon, 21 Jan 2002 15:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288058AbSAUUGs>; Mon, 21 Jan 2002 15:06:48 -0500
Received: from colorfullife.com ([216.156.138.34]:28179 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S288040AbSAUUGm>;
	Mon, 21 Jan 2002 15:06:42 -0500
Message-ID: <3C4C74B2.27BD7796@colorfullife.com>
Date: Mon, 21 Jan 2002 21:06:10 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Lee Packham <linux@mswinxp.net>
CC: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'Kai Germaschewski'" <kai@tp1.ruhr-uni-bochum.de>,
        "'Linus Torvalds'" <torvalds@transmeta.com>,
        "'Dave Jones'" <davej@suse.de>,
        "'Jes Sorensen'" <jes@wildopensource.com>,
        linux-kernel@vger.kernel.org,
        "'Marcelo Tosatti'" <marcelo@conectiva.com.br>
Subject: Re: [patch] VAIO irq assignment fix
In-Reply-To: <fa.gd40p7v.187cd9o@ifi.uio.no> <fa.fhsq5hv.1q2eri1@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Packham wrote:
> 
> Now... I have a Sony Vaio FX-103 with the RICOH RL5C476 not the 75. The
> laptop has 192 MB of RAM (not the standard 64) and a 10gb harddisk.
> Mandrake 8.1 with a 2.4.16 kernel with a USB PCI IRQ Routing patch to
> make USB work (yes I am waiting heavily for the ACPI stuff!).
> 
> Anyhow, no matter what I do (including your patch modified to work on
> the different controller) I cannot get two cards to work inside this
> laptop.
>
Have you tried Ingo's IRQ rate limiter? Perhaps someone forgets to send
an EOI to the hardware, and then everything locks up due to a level
triggered interrupt that remains active forever.

http://groups.google.com/groups?hl=en&selm=fa.o69hfov.tl2696%40ifi.uio.no&rnum=5

--
	Manfre
