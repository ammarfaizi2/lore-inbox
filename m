Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTFIVKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTFIVKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:10:30 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:206 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262018AbTFIVK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:10:29 -0400
Date: Mon, 9 Jun 2003 23:23:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New system device API
Message-ID: <20030609212348.GB508@elf.ucw.cz>
References: <20030609210706.GA508@elf.ucw.cz> <Pine.LNX.4.44.0306091412440.11379-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306091412440.11379-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, but you should keep "new" functions as similar to existing ones
> > as possible. That means 3 parameters for suspend functions, and as
> > similar semantics to existing callbacks as possible.
> 
> Did you read the earlier posts? They are similar, and simplified because 
> they don't need the level, since all suspend/resume is expected to happen 
> with interrupts disabled. The semantics are obvious, the deviation 
> trivial, and this thread a dead horse. 

The deviation is *not* trivial, and because I can not give you example
does not mean it does not exist.

> > > So? A keyboard controller is not classified as a system device.
> > 
> > Its not on pci, I guess it would end up as a system device...
> 
> Huh? Since when is everything that's not PCI a system device? Please read 
> the documentation, esp. WRT system and platform devices.

Well, can you be a little more concrete? I do not see any description
about what is system device and what is not.

Keyboard controller is very deeply integrated into the system. If it
is not system device, what is it?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
