Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281205AbRKPFaC>; Fri, 16 Nov 2001 00:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281203AbRKPF3w>; Fri, 16 Nov 2001 00:29:52 -0500
Received: from [24.198.47.158] ([24.198.47.158]:30217 "EHLO golux.thyrsus.com")
	by vger.kernel.org with ESMTP id <S281162AbRKPF3m>;
	Fri, 16 Nov 2001 00:29:42 -0500
Date: Fri, 16 Nov 2001 00:25:27 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Greg KH <greg@kroah.com>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.8.6 is available -- bug list is cleared
Message-ID: <20011116002527.A11550@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Greg KH <greg@kroah.com>, CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011115001659.A9067@thyrsus.com> <20011115111839.A10955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011115111839.A10955@kroah.com>; from greg@kroah.com on Thu, Nov 15, 2001 at 11:18:39AM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com>:
>  - CONFIG_USB_UHCI and CONFIG_USB_UHCI_ALT should be able to be selected
>    as modules at the same time.  Currently they are not.
>  - USB Serial menu should be below "USS720 parport driver"
>  - If USB_SERIAL = 'M' then USB_SERIAL_DEBUG should be not be shown.
>  - HOTPLUG_PCI_COMPAQ should be tristate.

Done for 1.8.7.

>  - USB_SERIAL_IR does not show up in the menu, is this due to there not
>    being a help entry for it?

That's right.  Symbols with no help are visible only when EXPERT is on.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

That the said Constitution shall never be construed to authorize
Congress to infringe the just liberty of the press or the rights of
conscience; or to prevent the people of the United states who are
peaceable citizens from keeping their own arms...
        -- Samuel Adams, in "Phila. Independent Gazetteer", August 20, 1789
