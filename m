Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSLVJ5a>; Sun, 22 Dec 2002 04:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbSLVJ5a>; Sun, 22 Dec 2002 04:57:30 -0500
Received: from lapd.cj.edu.ro ([193.231.142.101]:34480 "HELO lapd.cj.edu.ro")
	by vger.kernel.org with SMTP id <S264885AbSLVJ5a>;
	Sun, 22 Dec 2002 04:57:30 -0500
Date: Sun, 22 Dec 2002 12:05:31 +0200 (EET)
From: "Lists (lst)" <linux@lapd.cj.edu.ro>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Kernel 2.4.20 ...
In-Reply-To: <Pine.LNX.3.95.1021221204450.25703A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.43L0.0212221143290.7570-100000@lapd.cj.edu.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Dec 2002, Richard B. Johnson wrote:

> You are using some module that the linux-2.4.20 developers don't
> want you to use. Either it's not been converted to current conventions
> or it's proprietary an therefore can't be converted.

lsmod on my machine:
Module                  Size  Used by    Not tainted
via686a                 8480   0
eeprom                  3504   0  (unused)
i2c-proc                6416   0  [via686a eeprom]
i2c-isa                 1200   0  (unused)
i2c-dev                 3908   0  (unused)
i2c-viapro              4152   0  (unused)
i2c-core               15748   0  [via686a eeprom i2c-proc i2c-isa i2c-dev i2c-viapro]
ipip                    6788   1  (autoclean)
orinoco_cs              4808   2
orinoco                37288   0  [orinoco_cs]
hermes                  3460   0  [orinoco_cs orinoco]
ds                      6696   2  [orinoco_cs]
i82365                 22196   2
pcmcia_core            35072   0  [orinoco_cs ds i82365]
3c59x                  23716   2
pci-scan                3140   1  [3c59x]


I'm using modules for sensors (from lm_sensors), for orinoco PCMCIA card 
(from pcmcia-cs) and Donald Becker's drivers for 3c59x cards (the driver 
from the kernel it's not working for me). All of these are stable. What 
can I do?

Thank you,
Cosmin

