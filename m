Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265714AbUAKChc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 21:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265718AbUAKChc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 21:37:32 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:22163 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265714AbUAKCha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 21:37:30 -0500
Subject: Re: USB hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20040111002304.GE16484@one-eyed-alien.net>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk>
	 <20040111002304.GE16484@one-eyed-alien.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073788437.17793.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 11 Jan 2004 02:33:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-01-11 at 00:23, Matthew Dharm wrote:
> Where is USB kmalloc'ing with GFP_KERNEL?  I thought we tracked all those
> down and eliminated them.

Not sure. I just worked from tracebacks. I needed it to work rather
than having the time to go hunting for specific faults. Plus I'd
argue PF_MEMALLOC is a better solution anyway.

