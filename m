Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291247AbSBSLSE>; Tue, 19 Feb 2002 06:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291248AbSBSLRy>; Tue, 19 Feb 2002 06:17:54 -0500
Received: from holomorphy.com ([216.36.33.161]:11926 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291247AbSBSLRn>;
	Tue, 19 Feb 2002 06:17:43 -0500
Date: Tue, 19 Feb 2002 03:13:32 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Samium Gromoff <root@ibe.miee.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Ess Solo-1 interrupt behaviour
Message-ID: <20020219111332.GJ3511@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Samium Gromoff <root@ibe.miee.ru>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E16d81Q-00008y-00@the-village.bc.nu> <200202191344.g1JDiUP12170@ibe.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <200202191344.g1JDiUP12170@ibe.miee.ru>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Samium Gromoff wrote:
>>>         I`ve recently spotted that a solo1 pci soundcard generates
>>> 16000+ interrupts/second with esd started idling.

"  Alan Cox wrote:"
>> Thats an esd bug. ESD tries to use ridiculously small fragment sizes

I'm not sure what it is, but I traded in esd, the sound card, and the
scheduler upon gaining greater insight into this.

On Tue, Feb 19, 2002 at 04:44:28PM +0300, Samium Gromoff wrote:
>   Wait, wait, but my ISA Vibra 16 generates 20+ times less interrupts, with the
>   _same_ esd! 

A lot of it is the hardware. I haven't looked very hard at the drivers,
but my time/money tradeoff seemed to scream "just get new hardware you
don't have time to look at the code down there". Maybe someone else does...

Any volunteers? I'd at least be willing to run tests. I've seen this too.

Cheers,
Bill
