Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRATOWu>; Sat, 20 Jan 2001 09:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRATOWk>; Sat, 20 Jan 2001 09:22:40 -0500
Received: from 98-VALL-X8.libre.retevision.es ([62.83.212.98]:15232 "HELO
	lightside.2y.net") by vger.kernel.org with SMTP id <S129561AbRATOWd>;
	Sat, 20 Jan 2001 09:22:33 -0500
Date: Sat, 20 Jan 2001 15:22:29 +0100
From: Ragnar Hojland Espinosa <ragnar@fuckmpaa.com>
To: Jason Saunders <jason@iwantafreemobile.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Warnings on compiling 2.4.1-pre8
Message-ID: <20010120152229.A6061@lightside.2y.net>
In-Reply-To: <0101191115270D.20271@www.auctionline.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <0101191115270D.20271@www.auctionline.co.uk>; from Jason Saunders on Fri, Jan 19, 2001 at 11:15:27AM +0000
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 11:15:27AM +0000, Jason Saunders wrote:
> Since about 2.4.0-prerelease, I've been getting odd errors on compilation. A 
> sample is included below. It happens for every source file that includes 
> <linux/module.h> - is it anything to worry about?
> 
> In file included from /usr/src/linux/include/linux/modversions.h:117,
>                  from /usr/src/linux/include/linux/module.h:21,
>                  from signal.c:11:
> /usr/src/linux/include/linux/modules/irsyms.ver:1: warning: 
> `__ver_irttp_open_tsap' redefined
> /usr/src/linux/include/linux/modules/irmod.ver:1: warning: this is the 
> location
> of the previous definition
[...]

try a make mrproper

-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
