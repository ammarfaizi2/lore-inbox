Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270261AbRHMPq6>; Mon, 13 Aug 2001 11:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270263AbRHMPqs>; Mon, 13 Aug 2001 11:46:48 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:7043 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270261AbRHMPqh>; Mon, 13 Aug 2001 11:46:37 -0400
Date: Mon, 13 Aug 2001 08:46:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compile of drivers/pci/pci.c in 2.4.9-pre2
Message-ID: <20010813084635.E9133@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010813083100.C9133@cpe-24-221-152-185.az.sprintbbd.net> <20010813.083747.74740250.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010813.083747.74740250.davem@redhat.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2001 at 08:37:47AM -0700, David S. Miller wrote:
>    From: Tom Rini <trini@kernel.crashing.org>
>    Date: Mon, 13 Aug 2001 08:31:00 -0700
> 
>    Hello.  2.4.9-pre2 introduced the mandatory PM transition delays for PCI
>    devices.  However, it currently doesn't compile, at least on PPC, since
>    drivers/pci/pci.c doesn't include <asm/delay.h> to get the definition of
>    udelay.  Please apply this to the next release.  Thanks.
> 
> The correct include is <linux/delay.h> not <asm/delay.h>

Ah, whoops.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
