Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269580AbRHLX7G>; Sun, 12 Aug 2001 19:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269583AbRHLX65>; Sun, 12 Aug 2001 19:58:57 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:50187 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S269580AbRHLX6h>;
	Sun, 12 Aug 2001 19:58:37 -0400
Date: Sun, 12 Aug 2001 16:57:21 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.8-ac2
Message-ID: <20010812165721.A2501@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've made a release of the Compaq Hotplug PCI driver against 2.4.8-ac2
available at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-2.4.8-ac2.patch.gz

Changes since last release:
	- forward ported to 2.4.8-ac2
	- removed some Compaq server only code that talked directly to
	  the BIOS and the pci address-space.  This should remove the
	  last objection that people had for the acceptance of this
	  driver.

thanks,

greg k-h
