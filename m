Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132426AbRDFWoz>; Fri, 6 Apr 2001 18:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132427AbRDFWog>; Fri, 6 Apr 2001 18:44:36 -0400
Received: from [213.166.15.20] ([213.166.15.20]:779 "EHLO
	mailth4.byworkwise.com") by vger.kernel.org with ESMTP
	id <S132426AbRDFWoa>; Fri, 6 Apr 2001 18:44:30 -0400
Message-ID: <3ACE4694.3FFD3236@FreeNet.co.uk>
Date: Fri, 06 Apr 2001 23:43:32 +0100
From: Sid Boyce <sidb@FreeNet.co.uk>
Reply-To: sidb@FreeNet.co.uk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: No USB under 2.4.3 and 2.4.3-ac?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This happens on a PIII/GigaByte 6BXE, Athlon 900/ABit KT7 and on a
friend's Cyrix M-II/333 with PC-Chips PC100 mobo and SIS chipset. The
PIII is a SuSE 6.4 base +++++, the others are SuSE 7.1 + modutils-2.4.5
and a few other bits.
	During boot and "lsusb" ver 0.7 only show the on-board USB chip, it
does not see the outboard Hub or devices. lsusb on the PIII will also
show the on-board chip, on the other machines it returns blank.
	We haven't yet tried USB as modules to see if it makes a difference.

# USB support
#
CONFIG_USB=y
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y

#
# USB Controllers
#
CONFIG_USB_UHCI=y      ####CONFIG_USB_UHCI_ALT=y on Athlon)

# USB Device Class drivers
CONFIG_USB_PRINTER=y

# USB Imaging devices
CONFIG_USB_SCANNER=m

# USB Multimedia devices
CONFIG_USB_OV511=m    #### on the Athlon

Regards

-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop.. Tel. 44-121 422 0375
