Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267733AbSLGHjn>; Sat, 7 Dec 2002 02:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267735AbSLGHjn>; Sat, 7 Dec 2002 02:39:43 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:22025 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S267733AbSLGHjm>;
	Sat, 7 Dec 2002 02:39:42 -0500
Date: Sat, 7 Dec 2002 08:44:57 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>, jgarzik@pobox.com
Subject: Re: /proc/pci deprecation?
Message-ID: <20021207074457.GE21070@alpha.home.local>
References: <997222131F7@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <997222131F7@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2002 at 12:18:05AM +0100, Petr Vandrovec wrote:
> It is invaluable during installation, when no lspci is installed yet.
> I know that I need e100/eepro100 for 
> 'Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM E', but I do not
> have even slightest idea what device 8086:2449 is, whether USB or NIC or
> VGA or some bridge.

at least, the file "modules.pcimap" tells you which modules support these
devices, by vendor/model codes. I once developped a little installation script
which loaded all the NICs it could by listing /proc/bus/pci/devices and
modules.pcimap. I too agree that names in /proc/pci are *really* useful, but I
often omit them when I need a very little image. Perhaps having a list of names
only for devices supported by the kernel and modules at compile time would be
an acceptable compromise ?

Regards,
Willy

