Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277711AbRJLOFQ>; Fri, 12 Oct 2001 10:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277708AbRJLOFG>; Fri, 12 Oct 2001 10:05:06 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:7940 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S277700AbRJLOEv>; Fri, 12 Oct 2001 10:04:51 -0400
Message-ID: <3BC6F876.9AC2C102@delusion.de>
Date: Fri, 12 Oct 2001 16:04:38 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.12-ac1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        Rui Sousa <rui.p.m.sousa@clix.pt>
Subject: Re: Linux 2.4.12-ac1
In-Reply-To: <20011012141726.A27516@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> 2.4.12-ac1
> 2.4.10-ac12
> o       EMU10K driver update                            (Rui Sousa)

It seems that the new EMU10K driver no longer has a PCM mixer channel.

Creative EMU10K1 PCI Audio Driver, version 0.16, 15:28:05 Oct 12 2001
PCI: Enabling device 00:0a.0 (0004 -> 0005)
PCI: Assigned IRQ 5 for device 00:0a.0
emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xa400-0xa41f, IRQ 5
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR?????)

Per default I have the following mixer channels:
volume, speaker, line, microphone, cd, igain, line1, phonein, phoneout,
video.

Additionally I have added two mixer channels via emu-dspmgr userspace
tools: bass, treble

Does the new driver require userspace configuration for the PCM mixer
or has it just vanished mysteriously?

Regards,
-Udo.
