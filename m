Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132265AbQLIW0p>; Sat, 9 Dec 2000 17:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132251AbQLIW0f>; Sat, 9 Dec 2000 17:26:35 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:65287 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132238AbQLIW0b>; Sat, 9 Dec 2000 17:26:31 -0500
Date: Sat, 9 Dec 2000 15:51:35 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Willy Tarreau <wtarreau@free.fr>
Cc: Mark Sutton <mes@capelazo.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <20001209155135.A14957@vger.timpanogas.org>
In-Reply-To: <Pine.GSO.4.10.10012082329290.27791-100000@lazo.capelazo.com> <976380540.3a32627c184c3@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <976380540.3a32627c184c3@imp.free.fr>; from wtarreau@free.fr on Sat, Dec 09, 2000 at 05:49:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 05:49:00PM +0100, Willy Tarreau wrote:

Alan has spoken.  If DANGEROUS doesn't get their attention, what 
will?

Jeff

> One problem with warnings at compile time is that in many cases, administrators
> use kernels provided by friends or collegues that "know linux better than them".
> If an admin uses a kernel in which write support has been activated to mount
> an NTFS file system without providing any option, he will get it mount R/W
> without any warning, then may destroy it at the first mistake or so.
> 
> perhaps we should add an option such as "force" to mount an NTFS r/w, and as
> suggested by JBG, print a KERN_EMERG message when attempting to mount it r/w
> without the "force" option.
> 
> we could also add a static counter which will make the first r/w mount always
> fail, to ensure people will read the message, and which would prevent people
> from mounting r/w from fstab.
> 
> just my $0.02.
> 
> BTW, I like the message about microsoft preventing from fixing the driver ;-)
> 
> Cheers,
> Willy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
