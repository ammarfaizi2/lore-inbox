Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313567AbSDLOV6>; Fri, 12 Apr 2002 10:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313990AbSDLOV5>; Fri, 12 Apr 2002 10:21:57 -0400
Received: from mail.uhg.net ([208.128.168.19]:24845 "EHLO
	UHGEXCHANGE00.uhg.net") by vger.kernel.org with ESMTP
	id <S313567AbSDLOV5>; Fri, 12 Apr 2002 10:21:57 -0400
Subject: ES1878 doesn't work in 2.4 series kernel
From: "Roach, Mark R." <mrroach@uhg.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 12 Apr 2002 09:13:40 -0500
Message-Id: <1018620823.24746.23.camel@tncorpmrr001.uhg>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a compaq armada 1592DMT and have been unable to get the sound
card to work under 2.4.17 or 2.4.18 kernels (debian stock kernels or
compiled from source). 

This card is not a PNP card. modprobing sb with all the options (irq=5
dma, etc) will load the module but cating things to /dev/dsp produces no
output. If I do a dd if=/dev/dsp of=/tmp/dsp I get Sound: IRQ/DRQ config
error messages.

I have tried disabling isapnp in my kernel, I have compiled sb into the
kernel(and passing the correct parameters at boot), I have tried alsa,
all to no avail. 

With kernel 2.2.20 it works great. no problems whatsoever. Is there a
change in the 2.4 series that I am not aware of? Is this card no longer
supported?

Thanks very much for any help you can give me.

Mark Roach



