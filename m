Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbSBCBEB>; Sat, 2 Feb 2002 20:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSBCBDs>; Sat, 2 Feb 2002 20:03:48 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44489 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S285747AbSBCBDe>;
	Sat, 2 Feb 2002 20:03:34 -0500
Date: Sat, 2 Feb 2002 20:03:32 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>, davem@redhat.com
Subject: Re: [PATCH] Generic HDLC patch for 2.5.3
Message-ID: <20020202200332.A3740@havoc.gtf.org>
In-Reply-To: <20020202190242.C1740@havoc.gtf.org> <E16XAnc-00010K-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16XAnc-00010K-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Feb 03, 2002 at 12:46:28AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2002 at 12:46:28AM +0000, Alan Cox wrote:
> > It adds undiscussed networking changed which I very much doubt DaveM
> > would approve of, and I do not approve of:  SIOCDEVICE is far too
> > generic for inclusion, and it adds a structure for passing untyped
> > data which is very definitely non-portable.
> 
> You need a very generic structure for WAN interfaces because they have
> ridiculously large numbers of configurable options. These changes were
> discussed over a year ago.
> 
> I agree with the comment about untyped data. That does want to be cleaned
> up a chunk more. 

Ok...   SIOC[GS]WANDEVICE or somesuch?

It could be made more portable and still say generic, IMHO.

	Jeff



