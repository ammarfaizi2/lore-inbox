Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288747AbSANI2U>; Mon, 14 Jan 2002 03:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288435AbSANI2A>; Mon, 14 Jan 2002 03:28:00 -0500
Received: from atlante.atlas-iap.es ([194.224.1.3]:17158 "EHLO
	atlante.atlas-iap.es") by vger.kernel.org with ESMTP
	id <S288411AbSANI16>; Mon, 14 Jan 2002 03:27:58 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: System locks up after "spurious 8259A interrupt: IRQ7"
Date: Mon, 14 Jan 2002 09:27:55 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16Q2TD-0005Gl-00@antoli.uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sporadically my machine hangs (no response to keyboard, can't connect
> via network, no interaction via remote-control) and the last thing I
> see (if I see anything at all) is something like
>
>
> --- snip ---
> [...]
> Jan 13 21:30:00 atlan CROND[2876]: (till) CMD (fetchmail&> /dev/null)
> Jan 13 21:30:09 atlan kernel: spurious 8259A interrupt: IRQ7.

I am having the same problem since several versions ago:

Jan 13 15:15:48 antoli kernel: spurious 8259A interrupt: IRQ7.

It always happens when X is started on the kernel tainted with the nvidia 
module. But never gave any problem at all.

I've never reported it due the tainted version. But it seems it's not 
directly related to nvidia driver nor the hardware.

I have an ASUS/Intel815 motherboard (BTW, the 8259A is the Intel programmable 
interrupt controller).

Regards,

-- 
  ricardo
Cuando usaba Mac, se reían porque no tenía línea de comandos.
Ahora que uso Linux, se ríen porque tengo línea de comandos.
