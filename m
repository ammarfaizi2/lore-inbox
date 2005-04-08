Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVDHM4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVDHM4z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 08:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVDHM4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 08:56:55 -0400
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:30091 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262803AbVDHM4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 08:56:52 -0400
Subject: Re: Crash during boot for 2.6.12-rc2.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Xine.LNX.4.44.0504051325520.12266-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0504051325520.12266-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1112965096.3140.4.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 08 Apr 2005 22:58:17 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I got exactly the same thing on both my P4 HT and my Celeron 933 :<.
Trying fresh builds.

Regards,

Nigel

On Wed, 2005-04-06 at 03:26, James Morris wrote:
> On Tue, 5 Apr 2005, James Morris wrote:
> 
> > > Surprise, surprise, it works OK here.
> > > 
> > > What compiler version?
> > 
> > gcc -v
> > Using built-in specs.
> > Target: i386-redhat-linux
> > Configured with: ../configure --prefix=/usr --mandir=/usr/share/man 
> > --infodir=/usr/share/info --enable-shared --enable-threads=posix 
> > --enable-checking=release --with-system-zlib --enable-__cxa_atexit 
> > --disable-libunwind-exceptions --enable-languages=c,c++,objc,java,f95,ada 
> > --enable-java-awt=gtk --host=i386-redhat-linux
> > Thread model: posix
> > gcc version 4.0.0 20050329 (Red Hat 4.0.0-0.38)
> > 
> > 
> > I'll try a fresh compile later.
> 
> Looks like it was a miscompile, newly compiled (without ccache, too) 
> kernel works fine.
> 
> 
> - James
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

