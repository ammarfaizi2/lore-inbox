Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283592AbRLKVRS>; Tue, 11 Dec 2001 16:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283675AbRLKVRI>; Tue, 11 Dec 2001 16:17:08 -0500
Received: from fmr01.intel.com ([192.55.52.18]:17110 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S283592AbRLKVRE>;
	Tue, 11 Dec 2001 16:17:04 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D7E1@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'John Huttley'" <john@mwk.co.nz>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
        "Acpi-linux (E-mail 2)" <acpi-devel@lists.sourceforge.net>
Subject: RE: [2.4.16 bug] Major failure
Date: Tue, 11 Dec 2001 13:16:51 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: John Huttley [mailto:john@mwk.co.nz]
> The video card is a GA-660, which is a TNT2 using the Xfree driver.
> I have tried a 2.4.17-pre8 kernel with power management switched off.
> There were no problems with this! It works just fine.
> I subsequently tried a kernel with the ACPI drivers compiled in.
> The system booted ok, but rather coming up with gdm, it gave
> a part lit screen with no visible raster.

Hi John,

What is this system? A desktop? What is the motherboard?

Please send me the output from:
- dmesg
- /proc/interrupts
- /proc/ioports
- /proc/iomem
- the output from /proc/acpi/dsdt (if possible) or get pmtools from
http://developer.intel.com/technology/iapc/acpi/downloads.htm and please
provide the output from acpidmp.

Thanks -- Regards -- Andy

PS you may also want to try the latest ACPI patch from that same site, but
my guess is it will not solve your problem.
