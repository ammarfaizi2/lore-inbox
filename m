Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQL2C10>; Thu, 28 Dec 2000 21:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQL2C1Q>; Thu, 28 Dec 2000 21:27:16 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:31239
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129257AbQL2C1E>; Thu, 28 Dec 2000 21:27:04 -0500
Date: Fri, 29 Dec 2000 14:56:36 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, chris@freedom2surf.net,
        linux-kernel@vger.kernel.org
Subject: Re: Repeatable Oops in 2.4t13p4ac2
Message-ID: <20001229145636.C16930@metastasis.f00f.org>
In-Reply-To: <20001229144609.B16930@metastasis.f00f.org> <E14BoiI-0004ch-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14BoiI-0004ch-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 29, 2000 at 01:52:07AM +0000
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 01:52:07AM +0000, Alan Cox wrote:

    The PCMCIA thing is unlikely to be related (there are no changes
    on any PCMCIA that actually worked on 13pre4). 

Oh, I'm sure it is unrelated -- it's just a good trigger for the
problem on my laptop.

    Reiserfs might be the trigger because the quota code changed, but
    if it did touch it I'd expect it to have failed to compile

No quotas, local version of reiserfs but probably not too divergent
from what else is out there.

    I'm going to go and do a detailed audit of the mm bits I have
    differing from Linus. For one I'd be much happier to differ in
    drivers with Linus and avoid differing in mm/vm internals stuff.

I'll resync to t13p5 and any new reiserfs change that might be
relevant and see how that goes; if that works I'll start merging in
ac2 and see when it breaks.



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
