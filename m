Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTFIVAQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTFIVAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:00:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:53226 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262023AbTFIVAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:00:07 -0400
Date: Mon, 9 Jun 2003 14:15:20 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New system device API
In-Reply-To: <20030609210706.GA508@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0306091412440.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Okay, but you should keep "new" functions as similar to existing ones
> as possible. That means 3 parameters for suspend functions, and as
> similar semantics to existing callbacks as possible.

Did you read the earlier posts? They are similar, and simplified because 
they don't need the level, since all suspend/resume is expected to happen 
with interrupts disabled. The semantics are obvious, the deviation 
trivial, and this thread a dead horse. 

Please present a case in which that will not work and I will change the
semantics.

> > So? A keyboard controller is not classified as a system device.
> 
> Its not on pci, I guess it would end up as a system device...

Huh? Since when is everything that's not PCI a system device? Please read 
the documentation, esp. WRT system and platform devices.

Thanks,


	-pat

