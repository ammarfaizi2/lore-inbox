Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267095AbSIRP5O>; Wed, 18 Sep 2002 11:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbSIRP5O>; Wed, 18 Sep 2002 11:57:14 -0400
Received: from dmz.hesby.net ([81.29.32.2]:26317 "HELO firewall.hesbynett.no")
	by vger.kernel.org with SMTP id <S267095AbSIRP5N> convert rfc822-to-8bit;
	Wed, 18 Sep 2002 11:57:13 -0400
Subject: Re: Virtual to physical address mapping
From: Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s?= 
	<oleavr-lkml@jblinux.net>
To: Jonathan Lundell <linux@lundell-bros.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p05111a09b9ae41850a64@[207.213.214.37]>
References: <1032328456.5812.16.camel@zole.jblinux.net> 
	<p05111a09b9ae41850a64@[207.213.214.37]>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Sep 2002 18:05:52 +0200
Message-Id: <1032365152.3480.14.camel@zole.jblinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 16:46, Jonathan Lundell wrote:
> At 7:54am +0200 9/18/02, Ole André Vadla Ravnås wrote:
> >I've noticed that ifconfig shows a base address and an interrupt
> >number.. However, I can't get that base address to correspond to
> >anything in /proc/iomem, which means that I can't determine which PCI
> >device (in this case) it corresponds to (guess the base address is
> >virtual). What I want is to find a way to get the PCI bus and device no
> >for the network device, but is this at all possible without altering the
> >kernel?
> 
> ETHTOOL_GDRVINFO will do that directly, if the driver supports it.

Wow, great!! Thanks a bunch, that's exactly what I was looking for! :-)

Best regards
Ole André


