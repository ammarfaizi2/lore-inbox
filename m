Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317756AbSFLS3V>; Wed, 12 Jun 2002 14:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317758AbSFLS3U>; Wed, 12 Jun 2002 14:29:20 -0400
Received: from [195.39.17.254] ([195.39.17.254]:7075 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317756AbSFLS3T>;
	Wed, 12 Jun 2002 14:29:19 -0400
Date: Wed, 12 Jun 2002 11:06:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: oliver@neukum.name, roland@topspin.com, wjhun@ayrnetworks.com,
        paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020612090639.GB986@elf.ucw.cz>
In-Reply-To: <20020610.233850.60926092.davem@redhat.com> <200206110938.52090.oliver@neukum.name> <20020611.003625.05877183.davem@redhat.com> <20020611.004305.96601553.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    The DMA_ALIGN attribute doesn't work, on some systems the PCI
>    cacheline size is determined at boot time not compile time.
> 
> Another note, it could be per-PCI controller what this cacheline size
> is.  We'll need to pass in a pdev to the alignment interfaces to
> do this correctly.
> 
> So none of this can be done at compile time folks.

But upper bound is certainly known at compile time, right?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
