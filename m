Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSAUOAK>; Mon, 21 Jan 2002 09:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSAUOAA>; Mon, 21 Jan 2002 09:00:00 -0500
Received: from mail2.infineon.com ([192.35.17.230]:31900 "EHLO
	mail2.infineon.com") by vger.kernel.org with ESMTP
	id <S286322AbSAUN7w> convert rfc822-to-8bit; Mon, 21 Jan 2002 08:59:52 -0500
X-Envelope-Sender-Is: Erez.Doron@savan.com (at relayer mail2.infineon.com)
Subject: Re: non volatile ram disk
From: Erez Doron <erez@savan.com>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C4C1A96.3504174D@loewe-komp.de>
In-Reply-To: <1011618928.2825.5.camel@hal.savan.com> 
	<3C4C1A96.3504174D@loewe-komp.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 21 Jan 2002 15:42:56 +0200
Message-Id: <1011620576.2978.0.camel@hal.savan.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

thanks for replying,

I already tried to map an MTD to physical memory, but got an error and
an mtd with size 0

dou you know why ?

regards
erez

On Mon, 2002-01-21 at 15:41, Peter Wächtler wrote:
> Erez Doron schrieb:
> > 
> > hi
> > 
> > I'm looking for a way to make a ramdisk which is not erased on reboot
> > this is for use with ipaq/linux.
> > 
> > i tought of booting with mem=32m and map a block device to the rest of
> > the 32M ram i have.
> > 
> > the probelm is that giving mem=32m to the kernel will cause the kernel
> > to map only the first 32m of physical memory to virtual one, so using
> > __pa(ptr) on the top 32m causes a kernel oops.
> > 
> > any idea ?
> > 
> 
> a MTD is the way to go, which uses the "reserved" mem area. 
> I assume that the RAM is battery backed
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

