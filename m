Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbTLIRqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 12:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbTLIRqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 12:46:00 -0500
Received: from mail.kroah.org ([65.200.24.183]:36261 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266097AbTLIRp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 12:45:59 -0500
Date: Tue, 9 Dec 2003 09:41:42 -0800
From: Greg KH <greg@kroah.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: henning@meier-geinitz.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: Re: USB scanner issue (Was: Re: Beaver in Detox!)
Message-ID: <20031209174141.GB9183@kroah.com>
References: <Pine.LNX.4.58.0311261239510.1524@home.osdl.org> <20031128182625.GP2541@stop.crashing.org> <20031201192158.GC23209@kroah.com> <20031201205216.GA4307@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201205216.GA4307@stop.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 01:52:16PM -0700, Tom Rini wrote:
> After a bit of mucking around (and possibly finding a bug with debian's
> libusb/xsane/hotplug interaction, nothing seems to run
> /etc/hotplug/usb/libusbscanner and thus only root can scan, anyone whose
> got this working please let me know), the problem does not exist if I
> only use  libusb xsane.
> 
> How about the following:
> ===== drivers/usb/image/Kconfig 1.5 vs edited =====

Nice, thanks.  I've applied this.

greg k-h
