Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265979AbUAKWm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUAKWm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:42:29 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:39062 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265979AbUAKWm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:42:28 -0500
Subject: Re: [linux-usb-devel] Re: USB hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
In-Reply-To: <200401110902.07054.oliver@neukum.org>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk>
	 <20040111002304.GE16484@one-eyed-alien.net>
	 <1073788437.17793.0.camel@dhcp23.swansea.linux.org.uk>
	 <200401110902.07054.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073860735.26585.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 11 Jan 2004 22:39:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-01-11 at 08:02, Oliver Neukum wrote:
> Until recently this line from usb-ohci.h read GFP_KERNEL instead of GFP_NOIO
> 
> #define ALLOC_FLAGS (in_interrupt () || current->state != TASK_RUNNING ? GFP_ATOMIC : GFP_NOIO)
> 
> Was it an earlier kernel without that change?

Its an UHCI controller.

