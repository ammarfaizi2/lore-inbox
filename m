Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269807AbRHDGAh>; Sat, 4 Aug 2001 02:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269808AbRHDGA1>; Sat, 4 Aug 2001 02:00:27 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:18450 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S269807AbRHDGAV>;
	Sat, 4 Aug 2001 02:00:21 -0400
Date: Fri, 3 Aug 2001 22:57:32 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.8-pre3
Message-ID: <20010803225732.D2996@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've made another release of the Compaq Hotplug PCI driver available
against 2.4.8-pre3 and 2.4.7-ac5 depending on which tree you like to
run.  It is available at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-2.4.8-pre3.patch.gz
and
	http://www.kroah.com/linux/hotplug/pci-hotplug-2.4.7-ac5.patch.gz

There is also a Changelog available at:
	http://www.kroah.com/linux/hotplug/pci-hotplug-Changelog

Changes since last release:
	- forward ported to 2.4.8-pre3 and 2.4.7-ac5
	- cleaned up lots of direct pci address space accesses with the
	  proper readX and writeX calls.

If anyone has any problems with this version, or sees anyplace that I
did not catch on my pci address space access cleanups, please let me
know.

thanks,

greg k-h
