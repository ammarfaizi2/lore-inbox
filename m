Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946250AbWKJLBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946250AbWKJLBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 06:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946410AbWKJLBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 06:01:51 -0500
Received: from adsl02.metz.linbox.com ([62.212.120.90]:9169 "EHLO
	fbxmetz.linbox.com") by vger.kernel.org with ESMTP id S1946250AbWKJLBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 06:01:50 -0500
Message-ID: <45545C1B.4040204@linbox.com>
Date: Fri, 10 Nov 2006 12:01:47 +0100
From: Ludovic Drolez <ludovic.drolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060628 Debian/1.7.8-1sarge7.1
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.18.2: cannot compile with gcc 3.0.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

When I try to compile the latest kernel with 3.0.4, I get a parse error:

In file included from include/asm/suspend.h:7,
                  from include/linux/suspend.h:5,
                  from arch/i386/kernel/asm-offsets.c:11:
include/asm/i387.h:55: warning: `always_inline' attribute directive ignored
include/asm/i387.h: In function `__save_init_fpu':
include/asm/i387.h:58: parse error before '[' token
include/asm/i387.h:68: parse error before '[' token
include/asm/i387.h: At top level:
include/asm/i387.h:96: warning: `always_inline' attribute directive ignored

With gcc 2.95.4, I get a "compiler too old" errors, and the same parsing 
error... so, gcc 3.0.4 (Debian Woody) will be also in the compiler blacklist, 
or can it be fixed ?

Cheers,

-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
http://lrs.linbox.org       - Free disk imaging and asset management
