Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSLMNhj>; Fri, 13 Dec 2002 08:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbSLMNhj>; Fri, 13 Dec 2002 08:37:39 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:60105
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263291AbSLMNhi>; Fri, 13 Dec 2002 08:37:38 -0500
Subject: Re: 2.5.51: new warning from lilo
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021212193451.GA458@elf.ucw.cz>
References: <20021212193451.GA458@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Dec 2002 14:23:38 +0000
Message-Id: <1039789418.25121.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-12 at 19:34, Pavel Machek wrote:
> Hi!
> 
> Lilo now presents me with new warning:
> 
> Warning: Kernel & BIOS return differing head/sector geometries for
> device 0x80
>     Kernel: 8944 cylidners, 15 heads, 63 sectors
>       BIOS: 525 cylinders, 255 heads, 63 sectors
> 
> lilo did not warn under 2.5.50. Now... Will it boot?

Someone took various bits of geometry mapping out of the kernel. It will
now give different values. As to whether lilo will still boot I don't
know. I'd be suprised if it was a problem. 

Alan

