Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273977AbRISAjq>; Tue, 18 Sep 2001 20:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273976AbRISAji>; Tue, 18 Sep 2001 20:39:38 -0400
Received: from ns01.vbnet.com.br ([200.230.208.6]:32932 "EHLO
	iron.vbnet.com.br") by vger.kernel.org with ESMTP
	id <S273975AbRISAjZ> convert rfc822-to-8bit; Tue, 18 Sep 2001 20:39:25 -0400
Date: Tue, 18 Sep 2001 21:39:59 -0300 (BRT)
From: carlos <carlos@techlinux.com.br>
X-X-Sender: carlos@skydive.techlinux
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Hardware detection tool 0.4.1
Message-ID: <Pine.LNX.4.40.0109182110250.19983-100000@skydive.techlinux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hardware detection tool 0.4.1

This version supports detection of PCI, ISA PnP, USB and PARPORT
devices.

ftp://ftp.techlinux.com.br/pub/people/carlos/kernel/hwd/hwd-0.4.1.tar.gz

TODO:
- PCMCIA detection/driver table
- use MODULE_DEVICE_TABLE macro
- use PCI Class
- finish serial mouse/modem detection
- finish psaux mouse detection
- better USB detection method
- some EISA/VL/ISA (non-PnP) cards detection \
        ( ex. sb-like card, isa scsi devs, etc )
- some PARPORT specific detection ( ex. Iomega ZIP )

Changelog:
* Sun Aug 26 2001 Carlos E. Gorges <carlos@techlinux.com.br>
- v0.1
- PCI and ISA PnP dev. tables/detection
- ProcFS support

* Thu Aug 30 2001 Carlos E. Gorges <carlos@techlinux.com.br>
- v0.2
- USB dev. table/detection

* Mon Sep  3 2001 Carlos E. Gorges <carlos@techlinux.com.br>
- v0.3
- PARPORT dev. detection

* Wed Sep  5 2001 Carlos E. Gorges <carlos@techlinux.com.br>
- v0.4
- rewrite [de]allocation of device struct for better [un]plugable \
  devices support
- Use usb_device->bus->busnum instead d.id/v.id in USB disconnect

* Tue Sep 18 2001 Carlos E. Gorges <carlos@techlinux.com.br>
- v0.4.1
- PSAUX(PS/2) port detection
- first SERIAL modem/mouse detection code
- show Identify



-- 
	 _________________________
	 Carlos E Gorges
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil
	 _________________________


