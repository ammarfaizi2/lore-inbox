Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbSLML56>; Fri, 13 Dec 2002 06:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSLML5k>; Fri, 13 Dec 2002 06:57:40 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4612 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262648AbSLML4p>;
	Fri, 13 Dec 2002 06:56:45 -0500
Date: Thu, 12 Dec 2002 21:23:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, jsimmons@infradead.org,
       benh@kernel.crashing.org, paulus@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: atyfb in 2.5.51
Message-ID: <20021212202323.GA789@elf.ucw.cz>
References: <1039596149.24691.2.camel@rth.ninka.net> <Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net> <20021211.124347.127990341.davem@redhat.com> <1039642510.18467.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039642510.18467.40.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Wed, 2002-12-11 at 20:43, David S. Miller wrote:
> > fbdev is nice, in the specific cases where the device fits the fbdev
> > model, because once you have the kernel bits you have X support :)
> 
> fbdev also can't be used in some situations on x86. Deeply fascinating
> things happen on some x86 processors if you execute a loop of code with
> an instruction that crosses two different memory types.

Sounds like cpu bug to me? What cpus are affected?

Could be worked around by pointing debug register at memory boundary?

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
