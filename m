Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132706AbQL1X33>; Thu, 28 Dec 2000 18:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132691AbQL1X3S>; Thu, 28 Dec 2000 18:29:18 -0500
Received: from Cantor.suse.de ([194.112.123.193]:8977 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132689AbQL1X3E>;
	Thu, 28 Dec 2000 18:29:04 -0500
Date: Thu, 28 Dec 2000 23:58:36 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, torvalds@transmeta.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
Message-ID: <20001228235836.A25388@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0012281637200.12364-100000@freak.distro.conectiva> <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com> <20001228231722.A24875@gruyere.muc.suse.de> <200012282233.OAA01433@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012282233.OAA01433@pizda.ninka.net>; from davem@redhat.com on Thu, Dec 28, 2000 at 02:33:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 02:33:07PM -0800, David S. Miller wrote:
>    Date: 	Thu, 28 Dec 2000 23:17:22 +0100
>    From: Andi Kleen <ak@suse.de>
> 
>    Would you consider patches for any of these points? 
> 
> To me it seems just as important to make sure struct page is
> a power of 2 in size, with the waitq debugging turned off this
> is true for both 32-bit and 64-bit hosts last time I checked.

Why exactly a power of two ? To get rid of ->index ? 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
