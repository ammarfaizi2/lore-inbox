Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267633AbUJDUUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267633AbUJDUUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 16:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUJDUUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 16:20:52 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25100 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S267633AbUJDUUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 16:20:50 -0400
Date: Mon, 4 Oct 2004 22:20:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: eyal@eyal.emu.id.au, linux-kernel@vger.kernel.org,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: 2.6.9-rc3-mm2: error: `u64' used prior to declaration
Message-ID: <20041004202016.GH18190@stusta.de>
References: <416160FE.2090107@eyal.emu.id.au> <20041004153515.GB12736@stusta.de> <20041004125937.7836e605.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004125937.7836e605.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 12:59:37PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> >  Would you accept a patch that changes all #include <asm/bitops.h> to
> >  #include <linux/bitops.h> ?
> 
> I have an easier solution - I'll drop
> 
> add-rotate-left-right-ops-to-bitopsh.patch
> add-rotate-left-right-ops-to-bitopsh-build-fix.patch
> sha512-use-asm-optimized-bit-rotation.patch

I have no specific opinion on them, but at least in my test builds they 
caused only exactly the one reported compile failure.

The #include change was meant as a simple general cleanup which would 
as a side effect remove this problem.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

