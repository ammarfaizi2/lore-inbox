Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266353AbUGPNkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUGPNkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 09:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266423AbUGPNkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 09:40:04 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:11274 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S266353AbUGPNjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 09:39:53 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: Generic patching instruction to fix inline bugs with gcc-3.4?
Date: Fri, 16 Jul 2004 15:39:18 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040716133432.GD4328@charite.de>
In-Reply-To: <20040716133432.GD4328@charite.de>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Linux-Systeme GmbH
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407161539.19195@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 July 2004 15:34, Ralf Hildebrandt wrote:

> Is there a generic approach to fix issues like this that happen when
> trying to build with gcc-3.4:

Search lkml archives. Adrian posted tons of fixes for build problems like this 
the last few days.

> > With gcc-3.4 I get:
> >
> > make[1]: Entering directory /usr/src/linux-2.6.8-rc1-mm1'
> > make[2]: arch/i386/kernel/asm-offsets.s' is up to date.
> >   CHK     include/linux/compile.h
> >     CC      drivers/net/8139too.o
> >     drivers/net/8139too.c: In function rtl8139_open':
> >     drivers/net/8139too.c:616: sorry, unimplemented: inlining failed
> > in call to 'rtl8139_start_thread': function body not available
> > drivers/net/8139too.c:1362: sorry, unimplemented: called from here
> > make[3]: *** [drivers/net/8139too.o] Error 1
> > make[2]: *** [drivers/net] Error 2
> > make[1]: *** [drivers] Error 2
> > make[1]: Leaving directory /usr/src/linux-2.6.8-rc1-mm1'
> > make: *** [stamp-build] Error 2

ciao, Marc
