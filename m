Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUBOQFj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 11:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbUBOQFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 11:05:39 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:42178 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265062AbUBOQFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 11:05:37 -0500
Date: Sun, 15 Feb 2004 17:05:16 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Peter Osterlund <petero2@telia.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 2.6.3-rc3
Message-ID: <20040215160516.GA7650@louise.pinerecords.com>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org> <m2znbk4s8j.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2znbk4s8j.fsf@p4.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb-15 2004, Sun, 10:17 +0100
Peter Osterlund <petero2@telia.com> wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Benjamin Herrenschmidt:
> >   o New radeonfb
> >   o Fix a link conflict between radeonfb and the radeon DRI
> >   o Fix incorrect kfree in radeonfb
> 
> It doesn't seem to work on my x86 laptop. The screen goes black when
> the framebuffer is enabled early in the boot sequence. The machine
> boots normally anyway and I can log in from the network or log in
> blindly at the console.

The same goes for my ThinkPad T40p.  The old driver works ok.

dmesg:
...
Kernel command line: root=/dev/hda3 rw video=radeonfb
...
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=252.00 Mhz, System=200.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: SXGA+ Single (85MHz)    
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
...
Console: switching to colour frame buffer device 116x47

-- 
Tomas Szepe <szepe@pinerecords.com>
