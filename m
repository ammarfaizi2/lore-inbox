Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273467AbRIQEZu>; Mon, 17 Sep 2001 00:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273468AbRIQEZk>; Mon, 17 Sep 2001 00:25:40 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:1167 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S273467AbRIQEZb>; Mon, 17 Sep 2001 00:25:31 -0400
Date: Sun, 16 Sep 2001 21:25:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bzImage target for PPC
Message-ID: <20010916212538.F14279@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E15ipks-0006sS-00@wagner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15ipks-0006sS-00@wagner>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 02:11:34PM +1000, Rusty Russell wrote:

> All the instructions (including the message after "make oldconfig")
> talk about "make bzImage".  So I suppose it's best to give in to this
> rampant Intelism 8)

What about 'bzlilo' and 'zlilo' ? Those are mentioned too.  Linus, please
don't apply this.  Hopefully Paul will say that too. :)

> --- working-pmac-module/arch/ppc/Makefile.~1~	Sat Aug 18 16:38:13 2001
> +++ working-pmac-module/arch/ppc/Makefile	Mon Sep 17 14:08:09 2001
> @@ -87,6 +87,9 @@
>  
>  BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd
>  
> +# All the instructions talk about "make bzImage".
> +bzImage: zImage
> +
>  $(BOOT_TARGETS): $(CHECKS) vmlinux
>  	@$(MAKEBOOT) $@

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
