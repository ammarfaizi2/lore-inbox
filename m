Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265752AbSLNSav>; Sat, 14 Dec 2002 13:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265797AbSLNSav>; Sat, 14 Dec 2002 13:30:51 -0500
Received: from vsmtp3.tin.it ([212.216.176.223]:49382 "EHLO smtp3.cp.tin.it")
	by vger.kernel.org with ESMTP id <S265752AbSLNSau>;
	Sat, 14 Dec 2002 13:30:50 -0500
Message-ID: <3DFB7B21.7040004@tin.it>
Date: Sat, 14 Dec 2002 19:40:33 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE-CD and VT8235 issue!!!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi, I have this chip on a MSI KT4 Ultra (KT400 and VT8235) and an 
Athlon 2400+.

I have noe the kernel 2.4.19 and all works fine, but 2.4.19 don't 
support this chip (so no DMA & Co) and I've decided to upgrade to 2.4.20 
to get it working.
I've compiled in the Debian Way ( kernel-package) and installed the 
kernel, then I've rebooted it.
During the startup progress it have initialized the HDs fine , but when 
he had reached the first CDROM ( a NEC DVD READER) it locked up with 
this message:

hdc: DMA disabled
hdc: drive is not ready for command
ide1: reset: success!

and it repeats this messages in an infinite loop , I don't know how to 
solve this , there isn't a patch or something else?

The kernel that I've tried (without success) are:

kernel 2.4.20 (original)
kernel 2.4.20 -ac2
kernel-source-2.4.20 package by debian + patches
kernel-2.5.50-ac1(doesen't boot)
kernel-2.5.53 (doesen't compiles)

Please help

Thank u

Byez

