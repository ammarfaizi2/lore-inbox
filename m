Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266778AbSIROpk>; Wed, 18 Sep 2002 10:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbSIROpk>; Wed, 18 Sep 2002 10:45:40 -0400
Received: from mail.coastside.net ([207.213.212.6]:11227 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S266778AbSIROpj> convert rfc822-to-8bit; Wed, 18 Sep 2002 10:45:39 -0400
Mime-Version: 1.0
Message-Id: <p05111a09b9ae41850a64@[207.213.214.37]>
In-Reply-To: <1032328456.5812.16.camel@zole.jblinux.net>
References: <1032328456.5812.16.camel@zole.jblinux.net>
Date: Wed, 18 Sep 2002 07:46:32 -0700
To: Ole =?iso-8859-1?Q?Andr=E9?= Vadla =?iso-8859-1?Q?Ravn=E5s?= 
	<oleavr-lkml@jblinux.net>,
       linux-kernel@vger.kernel.org
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: Virtual to physical address mapping
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:54am +0200 9/18/02, Ole André Vadla Ravnås wrote:
>I've noticed that ifconfig shows a base address and an interrupt
>number.. However, I can't get that base address to correspond to
>anything in /proc/iomem, which means that I can't determine which PCI
>device (in this case) it corresponds to (guess the base address is
>virtual). What I want is to find a way to get the PCI bus and device no
>for the network device, but is this at all possible without altering the
>kernel?

ETHTOOL_GDRVINFO will do that directly, if the driver supports it.
-- 
/Jonathan Lundell.
