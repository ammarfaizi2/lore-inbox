Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbRE1BF4>; Sun, 27 May 2001 21:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262894AbRE1BFq>; Sun, 27 May 2001 21:05:46 -0400
Received: from are.twiddle.net ([64.81.246.98]:24968 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S261493AbRE1BFh>;
	Sun, 27 May 2001 21:05:37 -0400
Date: Sun, 27 May 2001 18:05:18 -0700
From: Richard Henderson <rth@twiddle.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Ingo T. Storm" <it@lapavoni.de>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: 2.4.5 does not link on Ruffian (alpha)
Message-ID: <20010527180518.A19209@twiddle.net>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	"Ingo T. Storm" <it@lapavoni.de>, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr> <20010523210923.A730@athlon.random> <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de> <3B102822.625E01DF@mandrakesoft.com> <3B1032BE.72BD1336@mandrakesoft.com> <20010527163901.A18929@twiddle.net> <3B1193A8.6DB90579@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B1193A8.6DB90579@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, May 27, 2001 at 07:54:17PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 07:54:17PM -0400, Jeff Garzik wrote:
> FWIW the documentation seems to imply that the option is necessary only
> when directly booting from SRM, i.e.. no bootloader is involved at all. 

Err, well, you can't have _no_ bootloader.

> It uses the example of MILO's presence or absence as indicating the need
> for this option.

Exactly.  aboot doesn't substitute.

> So... is it safe to always enable this option, with a little hacking
> perhaps?  :)   

Well, yes, it is obviously possible.  The generic config
does what you want.  You just need to permanently enable
some of that configury.


r~
