Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbTIJTR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265627AbTIJTR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:17:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56848 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265576AbTIJTQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:16:14 -0400
Date: Wed, 10 Sep 2003 20:16:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Stephen Hemminger <shemminger@osdl.org>, jffs-dev@axis.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix type mismatch in jffs.
Message-ID: <20030910201607.G30046@flint.arm.linux.org.uk>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Linus Torvalds <torvalds@osdl.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Stephen Hemminger <shemminger@osdl.org>, jffs-dev@axis.com,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20030910181847.GO454@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0309101152060.25211-100000@home.osdl.org> <20030910190303.GP454@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030910190303.GP454@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Wed, Sep 10, 2003 at 08:03:04PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 08:03:04PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> 	a) you've snipped the critical part ;-)
> 	b) nobody sane uses that beast these days
> 	c) if somebody wants to grow a private patch - it's their time,
> after all...
> 
> Seriously, though, by now fs/jffs/* has only one real use - extracting
> data from old filesystem.  IIRC, there was even a talk about having it go
> the way of ext and xiafs.  He's dead, Jim...

It isn't that dead - I get the occasional patch from people wanting to keep
it working, although I really wish people would send them to dwmw2 rather
than myself.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
