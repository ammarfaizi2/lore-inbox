Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269879AbRHEBGn>; Sat, 4 Aug 2001 21:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269890AbRHEBGd>; Sat, 4 Aug 2001 21:06:33 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:56704 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S269879AbRHEBGR>; Sat, 4 Aug 2001 21:06:17 -0400
Message-ID: <3B6C9B0E.EF55EF8@randomlogic.com>
Date: Sat, 04 Aug 2001 18:02:06 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: MTRR and Athlon Processors
In-Reply-To: <E15TCIm-0005i6-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Is the mtrr code supposed to work properly for Athlon (Model 4) in
> > kernel 2.4.7?
> >
> > I still get mtrr errors/warnings.
> 
> Mismatched mtrr warnings indicate bios writers who cannot read
> specifications. 

This does not surprise me. In fact, I need to check Tyan's web site for
a BIOS update.

> The kernel will fix up after it

I also get this message:

Jul 29 03:33:00 keroon kernel: mtrr: type mismatch for f8000000,4000000
old: write-back new: write-combining

This happens quite often, especially with the agpgart and NVdriver
modules.

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
