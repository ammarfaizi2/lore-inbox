Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRAIXNR>; Tue, 9 Jan 2001 18:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbRAIXNH>; Tue, 9 Jan 2001 18:13:07 -0500
Received: from nathan.polyware.nl ([193.67.144.241]:51729 "EHLO
	nathan.polyware.nl") by vger.kernel.org with ESMTP
	id <S132453AbRAIXM7>; Tue, 9 Jan 2001 18:12:59 -0500
Date: Wed, 10 Jan 2001 00:12:55 +0100
From: Pauline Middelink <middelink@polyware.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] advansys.c: include missing restore_flags, etc
Message-ID: <20010110001255.A28432@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelin@polyware.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010109083007.A24914@polyware.nl> <E14FvwT-0006ML-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14FvwT-0006ML-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jan 09, 2001 at 10:23:47AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jan 2001 around 10:23:47 +0000, Alan Cox wrote:
> > >      save_flags(flags);
> > >      cli();
> > > @@ -9965,7 +9972,7 @@
> > >  }
> > 
> > Err, according tho wise ppl on this list, this does not work on
> > MIPSes. The flags thing must stay in the same stackframe.
> 
> Certainly doesnt work on sparc32, but then it didnt before. Inline it might

Oops my bad. Sparc it is.

    Met vriendelijke groet,
        Pauline Middelink
-- 
GPG Key fingerprint = 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
For more details look at my website http://www.polyware.nl/~middelink
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
