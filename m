Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVCCEzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVCCEzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVCCEzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:55:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:53203 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261530AbVCCEx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:53:27 -0500
Subject: Re: radeonfb blanks my monitor
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= "L. W. Meunier" <2@pervalidus.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0503030134200.311@darkstar.example.net>
References: <Pine.LNX.4.62.0503022347070.311@darkstar.example.net>
	 <1109823010.5610.161.camel@gaston>
	 <Pine.LNX.4.62.0503030134200.311@darkstar.example.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 03 Mar 2005 15:50:51 +1100
Message-Id: <1109825452.5611.163.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 01:39 -0300, Frédéric L. W. Meunier wrote:
> On Thu, 3 Mar 2005, Benjamin Herrenschmidt wrote:
> 
> > On Wed, 2005-03-02 at 23:51 -0300, Frédéric L. W. Meunier wrote:
> >> I just replaced my Matrox G400 with a Jetway Radeon 9600LE
> >> (256Mb). If I run 'modprobe radeonfb', the monitor blanks out
> >> and the power on light keeps flashing.
> >>
> >> What may be wrong ? Using 2.6.11.
> >
> > Do you have a way to capture the dmesg log produced ?
> 
> These are the lines before I have to use SysRq.
> 
> Mar  2 15:16:45 darkstar kernel: radeonfb: Found Intel x86 BIOS ROM Image
> Mar  2 15:16:45 darkstar kernel: radeonfb: Retreived PLL infos from BIOS
> Mar  2 15:16:45 darkstar kernel: i2c-algo-bit.o: dvi passed test.
> Mar  2 15:16:45 darkstar kernel: i2c-algo-bit.o: vga passed test.
> Mar  2 15:16:46 darkstar kernel: radeonfb: Monitor 1 type CRT found
> Mar  2 15:16:46 darkstar kernel: radeonfb: EDID probed
> Mar  2 15:16:46 darkstar kernel: radeonfb: Monitor 2 type no found
> 
> BTW, I don't know if it could be related, but my motherboard 
> only supports AGP 4x

There should be more than these... Does it continue booting afte the
screen goes blank or not at all ? Can you send the full dmesg log too ?
Also, enable radeonfb verbose debug in the config.

> > Also, does it work if radeonfb is built-in ?
> 
> I'll try later. Time to sleep.

Ok, thanks.

