Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289456AbSAVWGV>; Tue, 22 Jan 2002 17:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289462AbSAVWGL>; Tue, 22 Jan 2002 17:06:11 -0500
Received: from ns.suse.de ([213.95.15.193]:50449 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289456AbSAVWGB>;
	Tue, 22 Jan 2002 17:06:01 -0500
Date: Tue, 22 Jan 2002 23:05:55 +0100
From: Dave Jones <davej@suse.de>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.3-pre3 -- fbdev.c:1814: In function `riva_set_fbinfo': incompatible types in assignment
Message-ID: <20020122230555.H21203@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Miles Lane <miles@megapathdsl.net>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1011734552.24310.10.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1011734552.24310.10.camel@stomata.megapathdsl.net>; from miles@megapathdsl.net on Tue, Jan 22, 2002 at 01:22:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 01:22:31PM -0800, Miles Lane wrote:
 > 
 > gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon     -c -o fbdev.o fbdev.c
 > fbdev.c: In function `riva_set_fbinfo':
 > fbdev.c:1814: incompatible types in assignment
 > make[4]: *** [fbdev.o] Error 1
 > make[4]: Leaving directory `/usr/src/linux/drivers/video/riva'

 Change the -1 on that line to NODEV

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
