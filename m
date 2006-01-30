Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWA3Pqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWA3Pqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWA3Pqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:46:31 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:12050 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S932342AbWA3Pqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:46:30 -0500
Date: Mon, 30 Jan 2006 15:46:17 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, hugh@veritas.com,
       linux-kernel@vger.kernel.org, t.sailer@alumni.ethz.ch, perex@suse.cz,
       ralf@linux-mips.org
Subject: Re: ALSA on MIPS platform
Message-ID: <20060130154617.GC15563@deprecation.cyrius.com>
References: <Pine.LNX.4.61.0601261910230.15596@goblin.wat.veritas.com> <20060128.004540.59467062.anemo@mba.ocn.ne.jp> <s5h7j8l64ua.wl%tiwai@suse.de> <20060130.185608.30186596.nemoto@toshiba-tops.co.jp> <s5hoe1u3to1.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hoe1u3to1.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Takashi Iwai <tiwai@suse.de> [2006-01-30 11:18]:
> Well, as Hugu pointed out, that page reservation plays no longer any
> role.  The patch below should work too on 2.6.15 or later.

It doesn't solve the problem I have, those "wait source ready timeout
0x1410 [0x8c8c8c8c]" messages on a Cobalt Qube2 with a 64-bit MIPS
kernel.


Detecting hardware: de4x5 via82cxxx es1371 usb_uhci
de4x5 disabled in configuration.
Skipping unavailable/built-in via82cxxx module.
Skipping unavailable/built-in es1371 module.
Loading uhci_hcd module.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
uhci_hcd 0000:00:09.2: Found HC with no IRQ.  Check BIOS/PCI 0000:00:09.2 setup!
uhci_hcd 0000:00:09.2: init 0000:00:09.2 fail, -19
Running 0dns-down to make sure resolv.conf is ok...done.
Setting up networking...done.
Starting hotplug subsystem:
   pci     
     uhci-hcd: already loaded
wait source ready timeout 0x1410 [0x8c8c8c8c]  <- repeated 180 times
AC'97 0 analog subsections not ready
wait source ready timeout 0x1410 [0x8c8c8c8c] <- repeated 453 times
     snd-ens1371: loaded successfully
   pci      [success]
   usb     
   usb      [success]
   isapnp  
   isapnp   [success]
   ide     
   ide      [success]
   input   
   input    [success]
   scsi    
   scsi     [success]
done.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces...done.
Starting portmap daemon: portmap.

-- 
Martin Michlmayr
http://www.cyrius.com/
