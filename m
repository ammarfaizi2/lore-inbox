Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVIEJZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVIEJZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVIEJZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:25:32 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:51847 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S932492AbVIEJZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:25:31 -0400
Message-ID: <431C0EA7.8030309@cs.aau.dk>
Date: Mon, 05 Sep 2005 11:23:51 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: A Framework to automatically configure a Kernel
References: <20050905084236.46978.qmail@web51011.mail.yahoo.com>
In-Reply-To: <20050905084236.46978.qmail@web51011.mail.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice idea !

I really would like to have such feature.

I tried a bit your stuff, unfortunately, I got this:

[fleury@rade7 linux-2.6.13-autoconf]$ make auconfig
  HOSTCC  scripts/kconfig/auto_conf.o
scripts/kconfig/auto_conf.c: In function 'auto_conf':
scripts/kconfig/auto_conf.c:288: warning: pointer targets in passing
argument 2 of '__builtin_strncpy' differ in signedness
scripts/kconfig/auto_conf.c: In function 'must_have':
scripts/kconfig/auto_conf.c:301: error: syntax error at end of input
make[1]: *** [scripts/kconfig/auto_conf.o] Error 1
make: *** [auconfig] Error 2

Seems that you don't use gcc-4 !

Two questions:

1) Isn't the XML parser a bit overkilling ????

2) Why is the target called "auconfig" and not "autoconfig" (just like
we have a "menuconfig") ?

Speaking about this autoconfig thingy, haven't been any serious attempt
to grab as much information as possible from lspci, /proc, /sys and so
on to build at least a skeleton for the .config ?

Regards
-- 
Emmanuel Fleury

Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it.
  -- Brian W. Kernighan

