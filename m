Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267050AbSKSSQ3>; Tue, 19 Nov 2002 13:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267068AbSKSSQ3>; Tue, 19 Nov 2002 13:16:29 -0500
Received: from green.pwm-1.clinic.net ([216.204.105.145]:8198 "EHLO
	green.pwm-1.clinic.net") by vger.kernel.org with ESMTP
	id <S267050AbSKSSQ1>; Tue, 19 Nov 2002 13:16:27 -0500
Date: Tue, 19 Nov 2002 13:01:43 -0500 (EST)
From: David G Hamblen <dave@AFRInc.com>
Reply-To: dave@AFRinc.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
In-Reply-To: <1037726960.12086.22.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211191257270.4170-100000@puppy.afrinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 2002, Alan Cox wrote:

> > things. Or the aha152x driver which I still can't get going in 2.5 :-(
>
> 152x seems to work
> -

I'm running 2.5.47-ac4, and it compiles with aha152x, but pcmcia doesn't
work:

# modprobe pcmcia_core
/lib/modules/2.5.47-ac4-apm/kernel/drivers/pcmcia/pcmcia_core.o:
unresolved symbol pcibios_read_config_dword
/lib/modules/2.5.47-ac4-apm/kernel/drivers/pcmcia/pcmcia_core.o: insmod
/lib/modules/2.5.47-ac4-apm/kernel/drivers/pcmcia/pcmcia_core.o failed
/lib/modules/2.5.47-ac4-apm/kernel/drivers/pcmcia/pcmcia_core.o: insmod
pcmcia_core failed



			Dave


