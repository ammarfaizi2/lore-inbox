Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277708AbRJRNg2>; Thu, 18 Oct 2001 09:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277711AbRJRNgS>; Thu, 18 Oct 2001 09:36:18 -0400
Received: from cx739861-a.dt1.sdca.home.com ([24.5.164.61]:3844 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S277708AbRJRNf7>; Thu, 18 Oct 2001 09:35:59 -0400
Date: Thu, 18 Oct 2001 06:36:32 -0700
To: Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Kernel Link Problems
Message-ID: <20011018063632.A999@gnuppy>
In-Reply-To: <20011017162941.A32145@gnuppy> <20011018152516.A9089@oisec.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011018152516.A9089@oisec.net>
User-Agent: Mutt/1.3.23i
From: Bill Huey <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 03:25:16PM +0200, Cliff Albert wrote:
> > 	ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o piggy.o
> > 	ld: bvmlinux: Not enough room for program headers (allocated 2, need 3)
> > 	ld: final link failed: Bad value
> > 
> 
> Same thing happening here on 2.4.12-ac{2,3}, 2.4.12-ac1 will link correctly

It's a Debian problem. Downgrade to the previous version of binutils.

bill

