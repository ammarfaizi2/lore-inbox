Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUBPBSu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 20:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265284AbUBPBSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 20:18:50 -0500
Received: from [217.7.64.198] ([217.7.64.198]:56710 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id S265275AbUBPBSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 20:18:48 -0500
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux 2.6.3-rc3
Date: Mon, 16 Feb 2004 02:18:44 +0100
User-Agent: KMail/1.6
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org> <200402160138.02212.earny@net4u.de> <1076892215.6957.141.camel@gaston>
In-Reply-To: <1076892215.6957.141.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402160218.44351.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 16. Februar 2004 01:43, Benjamin Herrenschmidt wrote:
> On Mon, 2004-02-16 at 11:38, Ernst Herzberg wrote:
> > On Montag, 16. Februar 2004 01:29, Ernst Herzberg wrote:
> >
> > Haaaalt! Yes, works, __but__:
> >
> > If you start X, the console is gone. No recovery but reboot possible.
>
> Using ATI binary drivers or XFree ones ? What XFree version ? X
> loves to screw things up on console save/restore in interesting
> ways. I think it +/- puts the chip back into some VGA mode...
>
> Another patch I posted earlier (copied below) _might_ help as it
> force radeonfb to reprogram the mode. Let me know.

Sorry, does not work. Previous attached patch does not help.

I'm _not_ using any binary drivers, as far as i know ;-)
I'm using gentoo stable,  i don't know exactly which patches are applied to 
the x-server:-)

relevant entries in this config:

Section "Device"
        Identifier  "Card0"
        Driver      "vesa"
        VendorName  "ATI Technologies Inc"
        BoardName   "Unknown Board"
        BusID       "PCI:1:0:0"
EndSection

~Earny
