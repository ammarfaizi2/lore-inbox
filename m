Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSEINrc>; Thu, 9 May 2002 09:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312414AbSEINrb>; Thu, 9 May 2002 09:47:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62131 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312296AbSEINrb>;
	Thu, 9 May 2002 09:47:31 -0400
Date: Thu, 09 May 2002 06:35:23 -0700 (PDT)
Message-Id: <20020509.063523.63557716.davem@redhat.com>
To: andrea@suse.de
Cc: hugh@veritas.com, torvalds@transmeta.com, akpm@zip.com.au, cr@sap.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] double flush_page_to_ram
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020509154444.B8428@dualathlon.random>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Thu, 9 May 2002 15:44:44 +0200
   
   Fine with me if Marcelo drops it, but I guess sparc/m68k/mips users
   won't like not be able to use 2.4 kernels anymore unless they first
   rewrite the entere cache flushing in the middle of a stable series.
   If you don't drop it in late 2.4 then my suggestion looks still a nice
   common code cleanup and it's functional equivalent to the current
   2.4.19pre8 code, so it cannot go wrong.

I only suggest doing it for 2.5, repeat, only 2.5

And yes adding the flush_page_to_ram call in filemap_nopage was a bug
fix in 2.4.10.  I believe it was from one of the SH port maintainers.

