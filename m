Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280618AbRKOMWe>; Thu, 15 Nov 2001 07:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280781AbRKOMWP>; Thu, 15 Nov 2001 07:22:15 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:3343 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280660AbRKOMWE>;
	Thu, 15 Nov 2001 07:22:04 -0500
Date: Thu, 15 Nov 2001 23:17:38 +1100
From: Anton Blanchard <anton@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: groudier@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small sym-2 fix
Message-ID: <20011115231738.B27258@krispykreme>
In-Reply-To: <20011115153654.E22552@krispykreme> <20011115.021916.45712781.davem@redhat.com> <20011115223526.A27258@krispykreme> <20011115.034136.73653260.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115.034136.73653260.davem@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Using an 8K page size should really be transparent to
> any sane ELF userland, why not just do it?  Is there
> some hardcoded dependency in the ppc ELF stuff or is
> it just a "some of our kernel code still assumes PAGE_SIZE
> = 4K"?

Its just that the kernel code assumes 4k PAGE_SIZE. Fixing this is high
on my list but there are still more basic things to finish first :)

Anton
