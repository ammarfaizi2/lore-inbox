Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291775AbSB0WAu>; Wed, 27 Feb 2002 17:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292991AbSB0V7G>; Wed, 27 Feb 2002 16:59:06 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:34312 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292841AbSB0V5m>;
	Wed, 27 Feb 2002 16:57:42 -0500
Date: Wed, 27 Feb 2002 18:57:24 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "Michael H. Warfield" <mhw@wittsend.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        "Dennis, Jim" <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: crypto (was Re: Congrats Marcelo,)
In-Reply-To: <20020227161519.A13912@alcove.wittsend.com>
Message-ID: <Pine.LNX.4.33L.0202271855230.2801-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Michael H. Warfield wrote:
> On Tue, Feb 26, 2002 at 07:33:50PM -0300, Rik van Riel wrote:
> > On Tue, 26 Feb 2002, Jeff Garzik wrote:
>
> > > IMO it's time to get a good IPsec implementation in the kernel...
>
> > Where would we get one of those ?
>
> > The freeswan folks seem quite determined to not let any
> > americans touch their code, so inclusion of their stuff
> > into the kernel is out.
>
> 	No...  That's patently not true.
>
> 	They won't accept contributions from us, but we touch
> their code all the time.  If we didn't, how would we get any testing
> done, which they do accept from us.

> 	They won't accept contributions from US developers to their code
> base.  That does NOT mean that they will not accept contributing the IPSec
> kernel code to the kernel and the incorporation of klips into the kernel
> source tree.

Wouldn't that result in the following scenario:

1) freeswan gets merged into the kernel

2) davem fixes a networking thing which
   happens to touch freeswan

3) the freeswan developers don't take davem's
   fix into their tree

4) the next patch by the freeswan people doesn't
   apply to what's in the kernel


Somehow this scenario doesn't seem like it would make
the ipsec implementation very maintainable.

Maybe it would be better to use what the usagi people
are building, just to have an easier maintainable system?

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

