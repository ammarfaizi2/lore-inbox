Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbUKWUoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUKWUoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUKWUmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:42:31 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:38459 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261232AbUKWUkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:40:17 -0500
Message-ID: <41A39EA3.B8AD9C13@veritas.com>
Date: Tue, 23 Nov 2004 12:33:39 -0800
From: Bruce Korb <bkorb@veritas.com>
Organization: Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: missing build functionality?
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I do hope this is the right forum.  I didn't see a "linux-kernel-build" list.
Anyway, I do not see an obvious way to construct an object archive library
that I wish to use for multiple drivers.  There are two problems.  This:

> ifeq ($(ARCH),ia64) 
> 	CFLAGS_KERNEL = 
> endif

because I am making the archive for a loadable driver.  This is not right
because I am digging around in kernel make files to figure out how to
do this and I'm guessing it might be subject to change.  :-}

The other "problem" is merely a nuisance:

> WARNING: Symbol version dump /usr/src/Kernel/SLES9/linux-2.6.5-7.97-debug/Module
> .symvers is  missing, modules will have CONFIG_MODVERSIONS disabled.

this, presumably, 'cuz I'm not actually making a module.

Your help is greatly appreciated.

Regards, Bruce
