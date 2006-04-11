Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWDKLSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWDKLSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWDKLSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:18:10 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:63111 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750747AbWDKLSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:18:09 -0400
Date: Tue, 11 Apr 2006 13:18:03 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: menuconfig search (Re: [rfc] fix Kconfig, hotplug_cpu is needed
 for swsusp)
In-Reply-To: <20060408192959.1fa9f401.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0604111316480.928@yvahk01.tjqt.qr>
References: <20060329220808.GA1716@elf.ucw.cz> <200603300936.22757.ncunningham@cyclades.com>
 <20060329154748.A12897@unix-os.sc.intel.com> <200603300953.32298.ncunningham@cyclades.com>
 <Pine.LNX.4.61.0603301022400.30783@yvahk01.tjqt.qr>
 <20060403221537.79bb3af9.rdunlap@xenotime.net> <Pine.LNX.4.61.0604081030201.21887@yvahk01.tjqt.qr>
 <20060408192959.1fa9f401.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I.e. strip the Defined and Depends lines and crunch the Location lines inasfar
>> as that the full width of the window is used (break at col 70).
>
>I don't see any need to limit it to 70 columns wide.  It knows how to
>scroll left/right (using arrow keys).
>
Not because it does not know how to horizontally scroll, but because it 
takes quite some time for the user to scroll left/right. There's no Home or 
End key for the horizontal direction.

>I don't know if we are converging any, but I made a new patch:
>  http://www.xenotime.net/linux/patches/menuconfig-search2b.patch

Yes, this one looks good and satisfies me.

Acked-by: Jan Engelhardt <jengelh@gmx.de>


Jan Engelhardt
-- 
