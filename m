Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbUAIQ1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 11:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUAIQ1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 11:27:48 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:1670 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262131AbUAIQ1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 11:27:47 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 9 Jan 2004 08:26:58 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Jochen Hein <jochen@jochen.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0] Thinkpad 390E hangs after some time
In-Reply-To: <87isjlw23u.fsf@echidna.jochen.org>
Message-ID: <Pine.LNX.4.44.0401090825350.1871-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Jochen Hein wrote:

> Not here.  compiled with both:
> 
> root@hermes:/usr/src# gcc -v
> Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.2/specs
> Konfiguriert mit: ../src/configure -v
> --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang
> --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info
> --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared
> --with-system-zlib --enable-nls --without-included-gettext
> --enable-__cxa_atexit --enable-clocale=gnu --enable-debug
> --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc
> i486-linux
> Thread model: posix
> gcc-Version 3.3.2 (Debian)
> root@hermes:/usr/src# gcc-2.95 -v
> Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
> gcc version 2.95.4 20011002 (Debian prerelease)
> 
> Anyway, got a new (faster) laptop and will move my 2.6 tests there.

Get 2.6.1 and try. There was a subtle bug in the fork code that I believe 
it was the real source of my pain ;)



- Davide


