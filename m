Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbUDPQgw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUDPQgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:36:24 -0400
Received: from mail0.lsil.com ([147.145.40.20]:36255 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S263419AbUDPQfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:35:44 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC53C@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Jord Tanner'" <jord@indygecko.com>, linux-kernel@vger.kernel.org
Cc: brad_mssw@gentoo.org, "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
Date: Fri, 16 Apr 2004 12:35:03 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please use the latest driver 2.20.0.B2, about to be released today. Please
provide a feedback if you see the same issues.

-Atul Mukker
LSI Logic

> -----Original Message-----
> From: Jord Tanner [mailto:jord@indygecko.com]
> Sent: Friday, April 16, 2004 9:57 AM
> To: linux-kernel@vger.kernel.org
> Cc: brad_mssw@gentoo.org; Atulm@lsil.com
> Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
> 
> 
> 
> On Tue Dec 30 2003 - 16:11:40 EST Brad House wrote:
> 
>         Ok, I just ported the 2.00.9 driver to 2.6.0.
>         It still has these warnings during compilation as I did not
>         attempt to apply my 64bit fixes from before as I've been told
>         they are just plain wrong :/
>         
>         But, I suppose this should work fine in 32bit mode, I would
>         greatly appreciate any help in porting it for 64bit platforms.
>         
>         The patch can be downloaded here :
>         
> http://dev.gentoo.org/~brad_mssw/kernel_patches/megaraid/megar
> aid-v2.00.9-linux2.6.patch
>         And only applies to the source from ftp.lsil.com, it's not a
>         kernel-patch
>         per-se, but copying the result over to the drivers/scsi will
>         compile inplace
>         of the current versions.
>         
>         Please CC me on any replies!
>         -Brad House <brad_mssw@xxxxxxxxxx>
> 
> 
> 
> This thread has been inactive for a while, but I've not found anything
> more relevant to my situation. 
> 
> I'm running 2.6.3-gentoo (and 2.6.5-gentoo) with a LSILogic SATA
> Megaraid 150-6 raid controller on a dual Opteron system. The entire
> system is compiled in 64bit. We are seeing random database corruption
> when access very large Postgres tables (more than 10 million rows).
> Other than that, the system runs beautifully.
> 
> As far as I can tell, no amd64 specific patches have been 
> applied to the
> megaraid driver in 2.6.3 (version 2.00.3). Brad House has posted a 2.6
> patch for megaraid 2.00.9, but his previous amd64 patches 
> were removed.
> LSI tech support has suggested I upgrade to 2.00.9, but the LSI source
> is for 2.4.
> 
> So my questions are:
> 
>         - Could the 2.00.3 driver be responsible for random data
>         corruption when running on 2.6.3 in 64bit?
>         - Is it safe to run Brad House's 2.6 megaraid 2.00.9 
> patches in
>         64 bit mode on amd64?
>         - Are there any patches for megaraid 2.00.9 (or higher, I see
>         2.00.10-3 has just been released) that combine patches for 2.6
>         and amd64?
>         
> TIA,
> 
> 
> -- 
> Jord Tanner <jord@indygecko.com>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
