Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTEEXco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 19:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTEEXco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 19:32:44 -0400
Received: from www.missl.cs.umd.edu ([128.8.126.38]:10254 "EHLO
	www.missl.cs.umd.edu") by vger.kernel.org with ESMTP
	id S261775AbTEEXbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 19:31:39 -0400
Date: Mon, 5 May 2003 19:52:26 -0400 (EDT)
From: Adam Sulmicki <adam@cfar.umd.edu>
X-X-Sender: adam@www.missl.cs.umd.edu
To: Thomas Horsten <thomas@horsten.com>
cc: Halil Demirezen <nitrium@bilmuh.ege.edu.tr>,
       <linux-kernel@vger.kernel.org>
Subject: Re: about bios
In-Reply-To: <Pine.LNX.4.40.0305060101350.7106-100000@jehova.dsm.dk>
Message-ID: <20030505193733.T76699-100000@www.missl.cs.umd.edu>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is why, even though Linux does not use the BIOS at any point after
> booting, some chipset setup code is still required and therefore you
> can't just burn a Linux kernel into flash and start it directly (there
> is a project called LinuxBIOS that was working on a replacement BIOS for
> some common chipsets, intended for embedded systems).

'was working'? The project is alive and well.

It is much more than just embedded systems. In fact with recent addition
of legacy bios support we are able to boot other operating systems (BSD,
Win, etc). Being able to boot Windows provides easy migration patch to
Linux :-)

By the way. Yes you can burn the linux kernel into flash (together with
linuxBIOS) and boot it this way. But given that many motherboards limit
your flash size to 256KiB you probably want to put the kernel on the
CompactFlash over ide nevertheless. Interestingly enough if not this size
limit we might have ended up using Linux Kernel as hardware initalizator
to some degree.

<shameless plug>
In fact we are presenting a paper on LinuxBIOS booting other operating
systems this summer during Usenix 03.
</shameless plug>

Adam

-- 
Adam Sulmicki
http://www.eax.com 	The Supreme Headquarters of the 32 bit registers





