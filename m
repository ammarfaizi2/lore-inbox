Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129768AbRCASl0>; Thu, 1 Mar 2001 13:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRCASlR>; Thu, 1 Mar 2001 13:41:17 -0500
Received: from cc946626-a.vron1.nj.home.com ([24.5.103.153]:12043 "EHLO
	tela.bklyn.org") by vger.kernel.org with ESMTP id <S129768AbRCASlC>;
	Thu, 1 Mar 2001 13:41:02 -0500
Date: Thu, 1 Mar 2001 13:40:56 -0500
From: Caleb Epstein <cae@bklyn.org>
To: Florian Nykrin <flo.n@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ld-error on 2.4.2 and on 2.4.1
Message-ID: <20010301134056.A9576@tela.bklyn.org>
Reply-To: Caleb Epstein <cae@bklyn.org>
In-Reply-To: <20010301193558.A15361@castor.olydorf.swh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010301193558.A15361@castor.olydorf.swh.mhn.de>; from flo.n@gmx.de on Thu, Mar 01, 2001 at 07:35:58PM +0100
Organization: Brooklyn Dust Bunny Mfg.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 07:35:58PM +0100, Florian Nykrin wrote:

> Hello, Because I don't know which maintainer to write I write to
> this list.  When I try to compile 2.4.2 or 2.4.1 I get the error: ld
> -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
> ld: cannot open binary: No such file or directory make[1]: ***
> [bbootsect] Error 1 make[1]: Leaving directory
> `/usr/src/linux-2.4.2/arch/i386/boot'

	perl -pi -e 's/-oformat/--oformat/' arch/i386/boot/Makefile

-- 
cae at bklyn dot org | Caleb Epstein | bklyn . org | Brooklyn Dust Bunny Mfg.
