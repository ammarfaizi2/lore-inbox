Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSKCSX6>; Sun, 3 Nov 2002 13:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbSKCSX6>; Sun, 3 Nov 2002 13:23:58 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2052 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262303AbSKCSX5>;
	Sun, 3 Nov 2002 13:23:57 -0500
Date: Sun, 3 Nov 2002 08:40:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Naohiko Shimizu <nshimizu@keyaki.cc.u-tokai.ac.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] Transparent SuperPage Support for 2.5.44
Message-ID: <20021103074002.GA4189@zaurus>
References: <20021028105849.424265cb.nshimizu@keyaki.cc.u-tokai.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028105849.424265cb.nshimizu@keyaki.cc.u-tokai.ac.jp>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is a transparent superpage support patch for 2.5.44.
> Big difference between this patch and 2.4.19 patch is
> eliminating of automatic dynamic downgrade for superpages.
> Instead, I place pagesize adjust routine where required.
> I hope this change minimize the overhead for conventional
> programs which does not use superpages.
> 
> Linux SuperPage patch is transparent for user applications.
> It will automatically allocate appropriate size of superpages
> if possible.
> It does not allocate real strage unless the application
> really access that area. And it does not allocate memory
> larger than the application requests.
> 
> This patch includes i386, alpha, sparc64 ports.
> But I could not compile for alpha even with plain 2.5.44, and
> I don't have sparc64 to test, then only i386 was tested now.

How do you swap these 4mb beasts?
And you need 4mb, physically continuous
area for this to work, right? How do you
get that?
			PavelEnd_of_mail_magic_4294
# New mail (delim 4464)
/usr/sbin/sendmail -oem -oi -N failure,delay -R full -- linux@linux.cz << End_of_mail_magic_4464
Date: Sun, 3 Nov 2002 09:53:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux@linux.cz
Subject: Re: Komprimovany filesystem ?
Message-ID: <20021103085349.GB4189@zaurus>
References: <slrnar9h47.59n.tripie@tripie.tripie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnar9h47.59n.tripie@tripie.tripie>
User-Agent: Mutt/1.3.27i


> Snazim se najit nejaky realtime komprimovany filesystem pro Linux
> s podporou cteni i zapisu. Mam na mysli neco podobneho, jako byl
> kdysi Stacker nebo Doublespace pod DOS. Nenasel jsem bohuzel
> zadny, ktery by byl v soucasne dobe udrzovany a pouzitelny pod
> jadrem 2.4. Nejvice nadejnym se mi jevi projekt e2compr, bohuzel
> vsak existuje pouze verze pro jadra 2.2.

e2compr pro 2.4 existuje....

> Jeste lepsim resenim nez specialni komprimovany filesystem by
> byla komprimovana loop device, podobne reseni jake je pouzito u
> projektu LoopAES.

To nejde protoze komprese meni velikost
dat....
 			PavelEnd_of_mail_magic_4464
