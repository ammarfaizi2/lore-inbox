Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290084AbSBOQfd>; Fri, 15 Feb 2002 11:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290081AbSBOQfV>; Fri, 15 Feb 2002 11:35:21 -0500
Received: from dspnet.claranet.fr ([212.43.196.92]:21512 "HELO
	dspnet.fr.eu.org") by vger.kernel.org with SMTP id <S290012AbSBOQfF>;
	Fri, 15 Feb 2002 11:35:05 -0500
Date: Fri, 15 Feb 2002 17:35:04 +0100
From: Jean-Luc Leger <reiga@dspnet.fr.eu.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: CML2-2.3.0 is available
Message-ID: <20020215173504.B85139@dspnet.fr.eu.org>
In-Reply-To: <20020214193329.A23463@thyrsus.com> <20020215042631.A23535@zalem.nrockv01.md.comcast.net> <20020215090624.B3047@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020215090624.B3047@thyrsus.com>; from esr@thyrsus.com on Fri, Feb 15, 2002 at 09:06:24AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 09:06:24AM -0500, Eric S. Raymond wrote:
> Symbol type is inferred from use in a menu.

what about those "legend" symbols that were in menus list but with
no menu declaration ?

ex:
menu usb        # USB? support
        USB_DEBUG
        usb_options_legend
        USB_DEVICEFS USB_BANDWIDTH USB_LONG_TIMEOUT
        usb_controllers_legend
        h:USB_UHCI? h:USB_UHCI_ALT? h:USB_OHCI?
...

I see no difference in use for usb_options_legend and USB_DEBUG.

	JL


