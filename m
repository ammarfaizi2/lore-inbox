Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbTAJNcT>; Fri, 10 Jan 2003 08:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbTAJNcT>; Fri, 10 Jan 2003 08:32:19 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:8601 "EHLO gatekeeper.slim")
	by vger.kernel.org with ESMTP id <S265102AbTAJNcT>;
	Fri, 10 Jan 2003 08:32:19 -0500
Subject: [2.4.20] e1000 as module gives unresolved symbol _mmx_memcpy
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1042206299.1694.12.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-1) 
Date: 10 Jan 2003 14:45:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While trying to use the e1000 as a module with kernel 2.4.20 it gives
me a unresolved symbol while trying to insmod the module. The offending
symbol is _mmx_memcpy. When the driver is compiled into the kernel
there's no problem.

I am running the kernel on a VIA Eden with 800MHz C3. Does this have
something to do with the fact that kernels for the VIA C3 are now
compiled with i486 optimisations (so maybe no MMX support?)?

Cheers,

Jurgen

