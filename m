Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266029AbUALANU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 19:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUALANT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 19:13:19 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:46486 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S266029AbUALANS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 19:13:18 -0500
Subject: Re: [linux-usb-devel] Re: USB hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Neukum <oliver@neukum.org>
Cc: David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
In-Reply-To: <200401120033.40230.oliver@neukum.org>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk>
	 <1073788437.17793.0.camel@dhcp23.swansea.linux.org.uk>
	 <4001DB52.7030908@pacbell.net>  <200401120033.40230.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073866181.26806.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 12 Jan 2004 00:09:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-01-11 at 23:33, Oliver Neukum wrote:
> For users of a kernel thread it helps. But what affects storage
> also make affect anything else that has a filesystem running
> over it. Plus it forces us to keep the storage thread model, which
> might be a solution that needs to be revisited.

Its a larger hammer, for 2.6 I agree that moving the right code to
GFP_NOIO is far better a solution. For 2.4 I just want it working with
minimal risk of screwups.

