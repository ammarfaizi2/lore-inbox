Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281105AbRKTPKn>; Tue, 20 Nov 2001 10:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281116AbRKTPK1>; Tue, 20 Nov 2001 10:10:27 -0500
Received: from t2.redhat.com ([199.183.24.243]:24564 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S281105AbRKTPKP>; Tue, 20 Nov 2001 10:10:15 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011120095018.A25289@thyrsus.com> 
In-Reply-To: <20011120095018.A25289@thyrsus.com> 
To: esr@thyrsus.com
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help missing entries list 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Nov 2001 15:10:07 +0000
Message-ID: <25065.1006269007@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
> It's down to 145 entries from 167 last week, thanks mostly to David
> Woodhouse documenting the new MTD symbols.  Please do what you can to
> empty this list by sending me help entries. 

You missed three that I sent you before. If you don't like my version of 
CONFIG_MEMORY_SET I'm sure you can come up with a new one - but the other 
two ought to be acceptable.


Physical memory size
CONFIG_MEMORY_SIZE
  This sets the default memory size assumed by your SH kernel. It can 
  be overridden as normal by the 'mem=' argument on the kernel command
  line. If unsure, consult your board specifications or just leave it
  as 0x00400000 which was the default value before this became
  configurable.

Darkness
CONFIG_MEMORY_SET
  This is an option about which you will never be asked a question. 
  Therefore, I conclude that you do not exist - go away.

  There is a grue here.

Cache and PCI noncoherent
CONFIG_SH_PCIDMA_NONCOHERENT
  Enable this option if your platform does not have a CPU cache which
  remains coherent with PCI DMA. It is safest to say 'Y', although you
  will see better performance if you can say 'N', because the PCI DMA 
  code will not have to flush the CPU's caches. If you have a PCI host
  bridge integrated with your SH CPU, refer carefully to the chip specs
  to see if you can say 'N' here. Otherwise, leave it as 'Y'.



--
dwmw2


