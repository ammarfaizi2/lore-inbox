Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTENVc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbTENVc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:32:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55252 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262955AbTENVc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:32:56 -0400
Date: Wed, 14 May 2003 23:45:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
Subject: 2.5.69-mm5: CONFIG_ACPI_SLEEP compile error
Message-ID: <20030514214536.GK1346@fs.tum.de>
References: <20030514012947.46b011ff.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514012947.46b011ff.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the following problem comes from Linus' tree:

<--  snip  -->

...
... --end-group  -o .tmp_vmlinux1
arch/i386/kernel/built-in.o(.data+0x1fae): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_esp'
arch/i386/kernel/built-in.o(.data+0x1fb3): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_eax'
arch/i386/kernel/built-in.o(.data+0x1fb9): In function `do_suspend_lowlevel':
: undefined reference to `saved_context_ebx'
...
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->




cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

