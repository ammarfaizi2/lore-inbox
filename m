Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVKFWte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVKFWte (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVKFWte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:49:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:43980 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751268AbVKFWtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:49:33 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: Re: NTP broken with 2.6.14
Date: Sun, 6 Nov 2005 23:49:18 +0100
User-Agent: KMail/1.8
Cc: john stultz <johnstul@us.ibm.com>, Len Brown <len.brown@intel.com>,
       macro@linux-mips.org, linux-kernel@vger.kernel.org, dean@arctic.org,
       zippel@linux-m68k.org
References: <4369464B.6040707@eclis.ch> <1131064846.27168.619.camel@cog.beaverton.ibm.com> <436ACC89.2050900@eclis.ch>
In-Reply-To: <436ACC89.2050900@eclis.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511062349.19257.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:d54c4b206b25008fd47cf8f4774f5606
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 4. November 2005 03:50 schrieb Jean-Christian de Rivaz:
>
> After trying several time, I am unable to upgrade the BIOS of this
> machine. The flash utility hang all the system at the very beginning
> of the real access to programm the flash! This is maybe because I use
> a freedos image over pxelinux. I will try with a floppy and a MSDOS
> if I found such olds stuffs somehere.

Could very well be the netboot stuff. I typically flash BIOS/firmware 
via DOS network boot images, which provides at least two different ways 
of disk emulation: a: and c:, but some flash tools just freeze the 
system on load/image load in both ways. Most prominently is the Promise 
TX2/100 firmware update, but also a couple of motherboards BIOS' 
flashers behave that way (cannot remember which ones, though). 

Pete
