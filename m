Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129911AbQLaSHn>; Sun, 31 Dec 2000 13:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130306AbQLaSHd>; Sun, 31 Dec 2000 13:07:33 -0500
Received: from Cantor.suse.de ([194.112.123.193]:11525 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129911AbQLaSHS>;
	Sun, 31 Dec 2000 13:07:18 -0500
Date: Sun, 31 Dec 2000 18:36:50 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
Message-ID: <20001231183650.A24467@gruyere.muc.suse.de>
In-Reply-To: <20001231182127.A24348@gruyere.muc.suse.de> <Pine.LNX.4.10.10012310924500.4029-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012310924500.4029-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 31, 2000 at 09:27:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 09:27:23AM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 31 Dec 2000, Andi Kleen wrote:
> > 
> > Sounds good. It could also be controlled by a CONFIG_SPACE_EFFICIENT for
> > embedded systems, where you could trade a bit of CPU for less memory overhead 
> > even on systems where u8 is slow and atomicity doesn't come into play
> > because it's UP anyways. 
> 
> UP has nothing to do with it.
> 
> The alpha systems I remember this problem on were all SMP.

AFAIK alpha has byte instructions now.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
