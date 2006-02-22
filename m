Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWBVMNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWBVMNe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBVMNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:13:34 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:898 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1750721AbWBVMNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:13:34 -0500
Date: Wed, 22 Feb 2006 13:13:28 +0100
From: Martin Mares <mj@ucw.cz>
To: Asfand Yar Qazi <ay0106@qazi.f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 'vga=' parameter wierdness
Message-ID: <mj+md-20060222.121130.6225.albireo@ucw.cz>
References: <43FC1624.8090607@qazi.f2s.com> <200602221130.13872.vda@ilport.com.ua> <43FC54B8.7070706@qazi.f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FC54B8.7070706@qazi.f2s.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> OK, will try that.  decimal of octal(0164) = decimal(116)

This won't work -- the mode numbers are hexadecimal, not octal.
Use 356 (decimal).

> When the modes come up on screen, they are numbered (0, 1, 2, ... a, b, 
> etc.) This is what the 'a' refers to.  Hey, it worked through LILO on 2.4 
>  kernels.

Beware, these menu item numbers are _not_ meant to be stable across
kernel upgrades. Better use the "long" mode numbers like 0164 or 030c.

> Before I type in scan, the number for the 132x60 mode is actually 030C.  
> After I've typed in 'scan', then it comes up as 0164.  If I enter 0164 
> BEFORE I type in 'scan' at the vid mode, it still works.  But not if I give 
> it as argument to GRUB.  As I said, will try giving decimal equivalent 
> (116) as argument to GRUB.

You can also try giving 0x164 to GRUB.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Computers are useless. They can only give you answers."  -- Pablo Picasso
