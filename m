Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbUAIPxB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbUAIPxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:53:01 -0500
Received: from main.gmane.org ([80.91.224.249]:60842 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262901AbUAIPw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:52:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jochen Hein <jochen@jochen.org>
Subject: Re: [2.6.0] Thinkpad 390E hangs after some time
Date: Fri, 09 Jan 2004 16:52:53 +0100
Message-ID: <87isjlw23u.fsf@echidna.jochen.org>
References: <87ptdv60r5.fsf@echidna.jochen.org> <Pine.LNX.4.44.0401071146140.2266-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.2 (gnu/linux)
Cancel-Lock: sha1:UGqkDCzOA0zTXCw7d42OZtikHd4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> On Wed, 7 Jan 2004, Jochen Hein wrote:
>
>> 
>> I'm running 2.6.0 (and .1-rc1) on an IBM Thinkpad 390E with 196MB RAM.
>> After some time - sometimes an hour or more, sometimes after a few
>> minutes, performance suffers, the machine feels sluggish.  After some
>> more minutes, the machine hangs.  No NMI-oopser, no ping, no panic
>> LEDs blinking.
>
> I had a very similar problem on two of my machines (CPQ laptop and IBM 
> NetVista). [...], but building 
> with 2.95.3 made my machines stable.

Not here.  compiled with both:

root@hermes:/usr/src# gcc -v
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.2/specs
Konfiguriert mit: ../src/configure -v
--enable-languages=c,c++,java,f77,pascal,objc,ada,treelang
--prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info
--with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared
--with-system-zlib --enable-nls --without-included-gettext
--enable-__cxa_atexit --enable-clocale=gnu --enable-debug
--enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc
i486-linux
Thread model: posix
gcc-Version 3.3.2 (Debian)
root@hermes:/usr/src# gcc-2.95 -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)

Anyway, got a new (faster) laptop and will move my 2.6 tests there.

Jochen

-- 
#include <~/.signature>: permission denied

