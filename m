Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTFVWrA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 18:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTFVWrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 18:47:00 -0400
Received: from lucidpixels.com ([66.45.37.187]:65455 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S263152AbTFVWq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 18:46:59 -0400
Date: Sun, 22 Jun 2003 19:01:05 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Spurious 8259A Interrupt IRQ 7
In-Reply-To: <1056322074.2075.40.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.56.0306221900080.4923@p500>
References: <20030622222014.7827.qmail@lucidpixels.com>
 <1056322074.2075.40.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will put my old ATA/100 board (Promise ATA/100 TX1) back in the box and
remove the ATA/133 (Promise TX2) and see if there are any more of these
spurious msgs.


On Sun, 22 Jun 2003, Alan Cox wrote:

> IRQ7 is raised if an interrupt appears and then vanishes again before it
> can be serviced. For 2.4.20/21 at least it can occur from the IDE layer
> and maybe others
>
>
