Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUGOKfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUGOKfO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 06:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUGOKfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 06:35:14 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:47324 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S264726AbUGOKfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 06:35:06 -0400
Date: Thu, 15 Jul 2004 12:35:04 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc1-mm1
Message-ID: <20040715103504.GC16230@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040713182559.7534e46d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040713182559.7534e46d.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc1/2.6.8-rc1-mm1/
> 
> - Lots of little fixes, mainly
> 
> - Numerous scheduling latency fixes, mainly in the ext3 area.
> 
>   This is a first pass - these patches need redoing and a bit of
>   infrastructure consolidation.
> 
> - Outta here: I won't be in a position to handle patches until July 26.  Off
>   to http://www.tech-forum.org/upcoming/open_source_software_06-10-04.htm and
>   then Kernel Summit and then OLS.

With gcc-3.4 I get:

make[1]: Entering directory /usr/src/linux-2.6.8-rc1-mm1'
make[2]: arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
    CC      drivers/net/8139too.o
    drivers/net/8139too.c: In function rtl8139_open':
    drivers/net/8139too.c:616: sorry, unimplemented: inlining failed
in call to 'rtl8139_start_thread': function body not available
drivers/net/8139too.c:1362: sorry, unimplemented: called from here
make[3]: *** [drivers/net/8139too.o] Error 1
make[2]: *** [drivers/net] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory /usr/src/linux-2.6.8-rc1-mm1'
make: *** [stamp-build] Error 2

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
