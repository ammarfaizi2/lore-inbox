Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKKCQb>; Fri, 10 Nov 2000 21:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129188AbQKKCQW>; Fri, 10 Nov 2000 21:16:22 -0500
Received: from sjc-wnds-1110.customers.reflexnet.net ([64.6.201.110]:51209
	"EHLO shambat.jokeslayer.com") by vger.kernel.org with ESMTP
	id <S129044AbQKKCQK>; Fri, 10 Nov 2000 21:16:10 -0500
Date: Fri, 10 Nov 2000 18:25:43 -0800 (PST)
From: Max Inux <maxinux@bigfoot.com>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <8ui1e9$bj7$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.30.0011101822120.10847-100000@shambat>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Nov 2000, H. Peter Anvin wrote:
>Different compile options?
>
>Why is a 900K kernel unusable?
>
>	-hpa

My guess would be it not actually bzipping the kernel.  Id run make
bzImage again and making sure  it is bzipping it.

On x86 machines there is a size limitation on booting.  Though I thought
it was 1024K as the max, 900K should be fine.

William Tiemann
wtiemann@openpgp.net
http://www.OpenPGP.Net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
