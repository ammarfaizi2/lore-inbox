Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266826AbSK1XNQ>; Thu, 28 Nov 2002 18:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266834AbSK1XNQ>; Thu, 28 Nov 2002 18:13:16 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:52727 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S266826AbSK1XNP>; Thu, 28 Nov 2002 18:13:15 -0500
Date: Thu, 28 Nov 2002 18:20:04 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM : AGP don't work for SiS 645DX chipset (Asus P4S533)
Message-ID: <20021128232004.GC7118@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021128230644.97656.qmail@web40506.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021128230644.97656.qmail@web40506.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 03:06:44PM -0800, Matthieu Fecteau wrote:
> Hello!
> 
> kernel (redhat) : 2.4.18-14
> 
> I don't know why, but the AGP do not work on this
> chipset and the hard drive and CD-Roms do not seem to
> be very fast, like it could.  Is it a problem with my
> machine or is it that the kernel is not currently
> supporting it.  Will it be supported one day by the
> kernel if it's the problem ?
>
 
The chipset isn't supported in that kernel. The AGP
looks for a PCI ID that isn't defined and the ATA/133
is not supported at all.

Alan Cox has full support for it in his 2.4.20-XXX-acX
patches and it works well.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

