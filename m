Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313906AbSEATGh>; Wed, 1 May 2002 15:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313914AbSEATGg>; Wed, 1 May 2002 15:06:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65293 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313906AbSEATGg>;
	Wed, 1 May 2002 15:06:36 -0400
Message-ID: <3CD03CC5.1030102@mandrakesoft.com>
Date: Wed, 01 May 2002 15:06:45 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Seiichi Nakashima <nakasima@kumin.ne.jp>
CC: linux-kernel@vger.kernel.org, nakasei@fa.mdis.co.jp
Subject: Re: 2.5.12 compile error ( e100, Alternate Intel driver )
In-Reply-To: <200205011123.AA00059@prism.kumin.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seiichi Nakashima wrote:

>Hi.
>
>I compile 2.5.12 without framebuffer console and boot up fine.
>First I use EtherExpressPro/100 support ( e100, Altrenate Intel driver ),
>but compile error occured. this driver is default.
>I change EtherExpressPro/100 support ( eepro100, original Becker driver ),
>then compile and boot up fine.
>
>=== compile error EtherExpressPro/100 support ( e100, Altrenate Intel driver ) ===
>
>io_apic.c:221: warning: `move' defined but not used
>drivers/net/net.o: In function `e100_diag_config_loopback':
>drivers/net/net.o(.text+0x52ff): undefined reference to `e100_phy_reset'
>make: *** [vmlinux] Error 1
>


this has been fixed and the fix has been sent to Linus.


