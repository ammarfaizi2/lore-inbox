Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263492AbTH3JE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 05:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTH3JE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 05:04:26 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:37504 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S263492AbTH3JEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 05:04:23 -0400
Date: Sat, 30 Aug 2003 11:04:11 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test4
Message-ID: <20030830090411.GD27477@charite.de>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@osdl.org>:
> 
> There should be a lot of compile fixes here, along with updates for ia64, 
> and the (painful) move of the 'name' entry out of the "struct device" that 
> helps avoid unnecessary memory waste.
> 
> It's a lot of small stuff all over: nothing really stands out in diffstat,
> except the big update of the Zoran video capture driver, and the blkmtd
> driver - both updated from their respective development trees (and the ips
> scsi driver, but that was due to massive whitespace fixing).
> 
> Normal merges with Andrew and arch maintainers (x86-64, ia64, sparc64,
> arm), and AGP updates (notably the merging of the ATI IGP). And network
> driver updates, ACPI and power management infrastructure.

This one is actually usable on my laptop (Sattelite Pro 6100 by
Toshiba). ACPI works, ALSA work, and it seems to work in general.

I still have issues with the keyboard -- sometimes when typing in the
frambuffer console I get an "unknown scancode" and after that the CTRL
key is stuck forever, which forces me to reboot.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
