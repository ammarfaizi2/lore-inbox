Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265146AbSJPQWS>; Wed, 16 Oct 2002 12:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbSJPQWS>; Wed, 16 Oct 2002 12:22:18 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:8886 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265146AbSJPQWR>;
	Wed, 16 Oct 2002 12:22:17 -0400
Date: Wed, 16 Oct 2002 18:27:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S. Miller" <davem@redhat.com>
cc: Nikita@Namesys.COM,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: XFS build error on m68k in 2.5.43
In-Reply-To: <20021016.050031.31945417.davem@redhat.com>
Message-ID: <Pine.GSO.4.21.0210161827200.9988-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, David S. Miller wrote:
>    From: Nikita Danilov <Nikita@Namesys.COM>
>    Date: Wed, 16 Oct 2002 15:31:03 +0400
>    
>    Second parameter of xfs_bmbt_disk_set_allf is 0 (zero). Try to replace
>    it with O.
> 
> You'll need lots more fixes ever after that, big-endian
> is pretty broke with the most recent updates.
> 
> Here are the fixes I sent to the XFS maintainers.

Thanks!

With these it compiles again on m68k, too.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

