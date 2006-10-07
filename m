Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWJGRGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWJGRGo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 13:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWJGRGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 13:06:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57604 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932318AbWJGRGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 13:06:44 -0400
Date: Sat, 7 Oct 2006 19:06:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, James.Bottomley@HansenPartnership.com
Subject: -git regression: Voyager compile error
Message-ID: <20061007170637.GS16812@stusta.de>
References: <200610071102.05384.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610071102.05384.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 11:02:04AM +0200, Jesper Juhl wrote:
>...
> And here are the errors :
> 
> 
> arch/i386/mach-voyager/voyager_basic.c:170: error: conflicting types for 'voyager_timer_interrupt'
> include/asm/voyager.h:508: error: previous declaration of 'voyager_timer_interrupt' was here
> arch/i386/mach-voyager/voyager_basic.c:170: error: conflicting types for 'voyager_timer_interrupt'
> include/asm/voyager.h:508: error: previous declaration of 'voyager_timer_interrupt' was here
> make[1]: *** [arch/i386/mach-voyager/voyager_basic.o] Error 1
> make: *** [arch/i386/mach-voyager] Error 2
> make: *** Waiting for unfinished jobs....
>...

David, commit 7d12e780e003f93433d49ce78cfedf4b4c52adc5 broke Voyager.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

