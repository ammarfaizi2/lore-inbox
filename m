Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264338AbTDWV7y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264342AbTDWV7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:59:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264338AbTDWV7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:59:50 -0400
Date: Wed, 23 Apr 2003 15:10:27 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "B. Joshua Rosen" <bjrosen@polybus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is anyone manitaing make xconfig?
Message-Id: <20030423151027.4d8bc4aa.rddunlap@osdl.org>
In-Reply-To: <1051135494.4872.26.camel@localhost.localdomain>
References: <1051135494.4872.26.camel@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Apr 2003 18:04:55 -0400 "B. Joshua Rosen" <bjrosen@polybus.com> wrote:

| Make xconfig has been broken for some time now, is anyone still
| maintaining it? I contacted the listed maintainer, Michael Elizabeth
| Chastain, who said that she is no longer maintaining it. 
| 
| Make xconfig is pretty important, it's hard to imagine that it's going
| to be allowed to rot.
| 
| Here is the compile error for 2.4.21-rc1,
| 
| /home/tmp/linux-2.4.20> make xconfig
| rm -f include/asm
| ( cd include ; ln -sf asm-i386 asm)
| make -C scripts kconfig.tk
| make[1]: Entering directory `/home/tmp/linux-2.4.20/scripts'
| cat header.tk >> ./kconfig.tk
| ./tkparse < ../arch/i386/config.in >> kconfig.tk
| drivers/ide/Config.in: 46: can't handle dep_bool/dep_mbool/dep_tristate
| condition
| make[1]: *** [kconfig.tk] Error 1
| make[1]: Leaving directory `/home/tmp/linux-2.4.20/scripts'
| make: *** [xconfig] Error 2

That's a config file problem, not an xconfig problem.
A patch for this has been posted several times.

--
~Randy
