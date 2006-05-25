Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWEYVKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWEYVKq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWEYVKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:10:46 -0400
Received: from jaguar.it.wsu.edu ([134.121.0.73]:45197 "EHLO jaguar.it.wsu.edu")
	by vger.kernel.org with ESMTP id S1751272AbWEYVKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:10:45 -0400
Message-ID: <44761D45.3090407@sandall.us>
Date: Thu, 25 May 2006 14:10:29 -0700
From: Eric Sandall <eric@sandall.us>
Organization: Source Mage GNU/Linux
User-Agent: Mail/News 1.5.0.2 (X11/20060427)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: b44 driver issues?
References: <200605251919.00614.dj@david-web.co.uk>
In-Reply-To: <200605251919.00614.dj@david-web.co.uk>
X-Enigmail-Version: 0.93.2.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Johnson wrote:
> Hi all,
> 
> I have a Dell Inspiron 5150 laptop with a Broadcom BCM4401 network card which 
> uses the b44 driver.
> 
> With recent kernels (I've tested with Ubuntu's 2.6.15,  vanilla 2.6.16.18 and 
> 2.6.17-rc5) the driver loads without error but the interface isn't 
> registered.
> 
> In dmesg:
> b44.c:v1.00 (Apr 7, 2006)
> ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 17 (level, low) -> IRQ 177
> eth0: Broadcom 4400 10/100BaseT Ethernet 00:11:43:7b:69:ae
> 
> # ifconfig eth0
> eth0: error fetching interface information: Device not found
> 
> With Ubuntu's 2.6.12 kernel everything works as expected. I've not tried any 
> kernels between 2.6.12 and 2.6.15, but can do so if it'd be helpful.
> 
> Anybody else having problems?

I have it working fine with 2.6.15.6 and prior. The few 2.6.16 kernels I
tested had it working as well.

- -sandalle

- --
Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEdh1EHXt9dKjv3WERAoDbAJ9xH/ZeQNwh5wTIt+QsurcNYH5NWgCfWc2r
eyDrJxJpePYni4Yz8Gxzy7A=
=NyXg
-----END PGP SIGNATURE-----
