Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261858AbSIXXnH>; Tue, 24 Sep 2002 19:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSIXXnH>; Tue, 24 Sep 2002 19:43:07 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:6828 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S261858AbSIXXnH>; Tue, 24 Sep 2002 19:43:07 -0400
Date: Tue, 24 Sep 2002 16:48:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC: unresolved module symbols in 2.4.20-pre7+bk
Message-ID: <20020924234815.GE788@opus.bloom.county>
References: <Pine.GSO.4.44.0209242216450.17647-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0209242216450.17647-100000@math.ut.ee>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 10:18:21PM +0300, Meelis Roos wrote:

> depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/macintosh/nvram.o
> depmod: 	pmac_get_partition
> depmod: 	nvram_write_byte_R9ce3f83f
> depmod: 	nvram_read_byte_R0f28cb91
> depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/media/video/tda7432.o
> depmod: 	__fixdfsi
> depmod: 	__floatsidf
> depmod: 	__divdf3
> depmod: 	__muldf3
> depmod: 	__subdf3
> depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/sound/dmasound/dmasound_pmac.o
> depmod: 	pmac_xpram_read
> depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/usb/storage/usb-storage.o
> depmod: 	ppc_generic_ide_fix_driveid

What compiler did you use, and when was the last time you did a
'mrproper' or 'distclean' in your tree or changed CONFIG_MODVERSIONS?
Two of the errors have modversions-type bits on them.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
