Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282213AbSADVpM>; Fri, 4 Jan 2002 16:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282684AbSADVpC>; Fri, 4 Jan 2002 16:45:02 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:23904 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S282213AbSADVos>; Fri, 4 Jan 2002 16:44:48 -0500
Date: Fri, 4 Jan 2002 23:44:38 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: esr@thyrsus.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: LSB1.1: /proc/cpuinfo
Message-ID: <20020104234438.G1331@niksula.cs.hut.fi>
In-Reply-To: <20020104080358.A11215@thyrsus.com> <E16MXjm-0004jo-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16MXjm-0004jo-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 04, 2002 at 05:02:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 05:02:34PM +0000, you [Alan Cox] claimed:
> > If the PPC etc. have 32-bit ints then I stand corrected, but I thought the 
> > compiler ports on those machines used the native register size same as
> > everybody else.
> 
> Nobody I am aware of uses 64bit int default types on a 64bit platform.  Its
> a waste of memory, bus bandwidth and instruction bandwidth. In almost
> all cases a 32bit int is quite adequate and since size_t can be 64bit when
> int is 32bit life works out nicely.

I *think* long is 32 bit on Windows XP 64bit, though. I imagine they went
with this hack to ensure backward compability or something. Can't tell for
sure since the IA64 box lying around hasn't got a bootable Windows on it
yet, just linux :).

http://msdn.microsoft.com/library/en-us/win64/64bitwin_4d0z.asp?frame=true


-- v --

v@iki.fi
