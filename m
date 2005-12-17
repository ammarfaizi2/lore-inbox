Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVLQVdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVLQVdP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVLQVdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:33:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39693 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932657AbVLQVdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:33:15 -0500
Date: Sat, 17 Dec 2005 22:33:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.15-rc5-git3] hpet.c causes FC4 GCC 4.0.2 to bomb with unrecognizable insn
Message-ID: <20051217213316.GT23349@stusta.de>
References: <5a4c581d0512130507n698846ao719c389f3c3ee416@mail.gmail.com> <20051217123636.cdd53270.akpm@osdl.org> <5a4c581d0512171250j1572c086j4fa56c41d19fa0ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0512171250j1572c086j4fa56c41d19fa0ae@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 09:50:29PM +0100, Alessandro Suardi wrote:
>...
> Sorry for the false alarm about GCC 4.0.2. According to the
>  current Documentation/Changes the 2.96 compiler seems to
>  be expected to build these kernels, so perhaps there still is
>  something to be looked into.
> 
> If anyone is interested I can try uninlining hpet_time_div()
>  and rebuild with 2.96 then report back.

In -mm, support for gcc < 3.2 has already been dropped making it 
relatively useless to work around gcc 2.96 internal errors.

> Thanks,
> 
> --alessandro

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

