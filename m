Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280943AbRKOSVi>; Thu, 15 Nov 2001 13:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280941AbRKOSUc>; Thu, 15 Nov 2001 13:20:32 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:53766 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280943AbRKOSUC>;
	Thu, 15 Nov 2001 13:20:02 -0500
Date: Thu, 15 Nov 2001 11:18:39 -0800
From: Greg KH <greg@kroah.com>
To: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.8.6 is available -- bug list is cleared
Message-ID: <20011115111839.A10955@kroah.com>
In-Reply-To: <20011115001659.A9067@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115001659.A9067@thyrsus.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 18 Oct 2001 17:44:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A few configuration bugs:

 - CONFIG_USB_UHCI and CONFIG_USB_UHCI_ALT should be able to be selected
   as modules at the same time.  Currently they are not.
 - USB Serial menu should be below "USS720 parport driver"
 - If USB_SERIAL = 'M' then USB_SERIAL_DEBUG should be not be shown.
 - USB_SERIAL_IR does not show up in the menu, is this due to there not
   being a help entry for it?
 - HOTPLUG_PCI_COMPAQ should be tristate.

thanks,

greg k-h
