Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290088AbSAKUL3>; Fri, 11 Jan 2002 15:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290087AbSAKULT>; Fri, 11 Jan 2002 15:11:19 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:31243 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S290086AbSAKULK>; Fri, 11 Jan 2002 15:11:10 -0500
Date: Fri, 11 Jan 2002 21:11:03 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Krzysztof Oledzki <ole@ans.pl>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: ide.2.2.21.05042001-Ole.patch.gz
Message-ID: <20020111211103.H16200@suse.cz>
In-Reply-To: <Pine.LNX.4.33.0201112043340.14442-100000@dark.pcgames.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201112043340.14442-100000@dark.pcgames.pl>; from ole@ans.pl on Fri, Jan 11, 2002 at 08:58:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 08:58:43PM +0100, Krzysztof Oledzki wrote:
> Hello,
> 
> I have just modified Andre Hedrick's ide.2.2.19.05042001 patch. You can
> find it at "http://www.ans.pl/ide/ide.2.2.21.05042001-Ole.patch.gz". It
> should patch 2.2.21pre2 kernel without any warnings/errors. I also
> bacported new VIA driver from 2.4.x kernel - this one uses correct IO port
> as via_base so values displayed in /proc/ide/via file are now properly
> calculated. Check the "BM-DMA base" value :)
> 
> Hopefully, devices which work in DMA mode, have DMA/UDMA value instead of
> PIO in "Transfer Mode" now. It also should works better with some new
> chipsets. If I found time I can also try to backport new Intel, Promise
> and HPT drivers if no no one else is working on it. I believe I have
> required hardware to test it.
> 
> I also have one question about IDE support in 2.4.x kernel. Why, with VIA
> MVP3 chipset on my FIC 503+ board, with UDMA33/66/100 HDDs using 2.4.x
> kernels I have only 13 MB/sec (tested with hdparm -t). With 2.2.x kernels
> hdparm shows 17 MB/sec but with IDE support bacported from 2.4.x kernels
> (2.2.19/2.2.20+original Andre Hedrick's patch) it is also 13 MB/sec.

If you can send me 'lspci -vvxxx' for both the cases, perhaps I'll be
able to find out why it is so. Is this with all the IDE patches or just
the VIA driver changed?

-- 
Vojtech Pavlik
SuSE Labs
