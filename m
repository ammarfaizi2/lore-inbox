Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284617AbRLRSyE>; Tue, 18 Dec 2001 13:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284557AbRLRSw6>; Tue, 18 Dec 2001 13:52:58 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:43787 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284604AbRLRSwb>;
	Tue, 18 Dec 2001 13:52:31 -0500
Date: Tue, 18 Dec 2001 10:49:19 -0800
From: Greg KH <greg@kroah.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file
Message-ID: <20011218104919.B5549@kroah.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D802@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D802@orsmsx111.jf.intel.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 20 Nov 2001 16:35:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 09:43:28AM -0800, Grover, Andrew wrote:
> Initrd exists to allow a two-phase startup. My point is that why have a 2
> phase startup when you can have a 1 phase startup? Also, I'm not advocating
> ditching the initrd capability, but wouldn't bootloading modules be
> preferable for the majority of the systems currently using initrd out of
> necessity?

Cool, how is GRUB going to do hotplug issues? :)

The 2 stage approach allows us to run /sbin/hotplug during kernel boot
so that we can load the proper pci/usb/firewire/whatever drivers for
whatever is currently plugged into the machine at boot time.

thanks,

greg k-h
