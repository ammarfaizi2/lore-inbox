Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267433AbTBUNdZ>; Fri, 21 Feb 2003 08:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTBUNdZ>; Fri, 21 Feb 2003 08:33:25 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:53436 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S267433AbTBUNdY>;
	Fri, 21 Feb 2003 08:33:24 -0500
Date: Fri, 21 Feb 2003 14:43:29 +0100 (MET)
From: News Admin <news@nimloth.ics.muni.cz>
Message-Id: <200302211343.h1LDhTM13523@nimloth.ics.muni.cz>
To: linux-kernel@vger.kernel.org
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From news Fri Feb 21 14:43:28 2003
Received: (from news@localhost)
	by nimloth.ics.muni.cz (8.11.6+Sun/8.10.0.Beta12) id h1LDhSm13508
	for newsmaster; Fri, 21 Feb 2003 14:43:28 +0100 (MET)
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: SMP kernel 2.4 and gcc-3.2
Message-ID: <3E562CFC.774860C7@i.am>
Sender: UNKNOWN@decibel.fi.muni.cz
Date: Fri, 21 Feb 2003 13:43:24 GMT
X-Nntp-Posting-Host: decibel.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
Organization: unknown

Hello

As I've so far not noticed any such post - maybe it's just me.

But I simply can not build usable SMP 2.4.2x kernel
with gcc-3.2

Whenever I use gcc-3.2 - the compiled kernel just immediately
reboots machine - Exactly the same kernel with same configuration
compiled with gcc-2.95 works normaly.
The box is Abit BP6/256MB Ram/Matrox G400 with 2xCelerons

I've just seen slightly different behavior with various
versions - sometime it just locked the box (i.e. GRUB screen
has stayed on the screen and I had to press 'reset' button
myself)

Ok - what should I do to help fix this problem - as I've said
I've tried various configuration - I don't think there
is something special in there (http://www.fi.muni.cz/~kabi/.config)

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/3.2.3/specs
Configured with: ../src/configure -v
--enable-languages=c,c++,java,f77,proto,pascal,objc,ada --prefix=/usr
--mandir=/usr/share/man --infodir=/usr/share/info
--with-gxx-include-dir=/usr/include/c++/3.2 --enable-shared
--with-system-zlib --enable-nls --without-included-gettext
--enable-__cxa_atexit --enable-clocale=gnu --enable-java-gc=boehm
--enable-objc-gc i386-linux
Thread model: posix
gcc version 3.2.3 20030210 (Debian prerelease)


please Cc: me

-- 
  .''`.
 : :' :    Zdenek Kabelac  kabi@{debian.org, users.sf.net, fi.muni.cz}
 `. `'           Debian GNU/Linux maintainer - www.debian.{org,cz}
   `-

