Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbQLOUpK>; Fri, 15 Dec 2000 15:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131308AbQLOUpB>; Fri, 15 Dec 2000 15:45:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:47446 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129652AbQLOUos>; Fri, 15 Dec 2000 15:44:48 -0500
Date: Fri, 15 Dec 2000 21:14:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Mike Black <mblack@csihq.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
Message-ID: <20001215211404.J17781@inspiron.random>
In-Reply-To: <20001215195433.G17781@inspiron.random> <Pine.LNX.4.21.0012151752421.3596-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0012151752421.3596-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, Dec 15, 2000 at 05:55:08PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 05:55:08PM -0200, Rik van Riel wrote:
> On Fri, 15 Dec 2000, Andrea Arcangeli wrote:
> 
> > x()
> > {
> > 
> > 	switch (1) {
> > 	case 0:
> > 	case 1:
> > 	case 2:
> > 	case 3:
> > 	;
> > 	}
> > }
> > 
> > Why am I required to put a `;' only in the last case and not in
> > all the previous ones?
> 
> That `;' above is NOT in just the last one. In your above
> example, all the labels will execute the same `;' statement.
> 
> In fact, the default behaviour of the switch() operation is
> to fall through to the next defined label and you have to put
> in an explicit `break;' if you want to prevent `case 0:' from
> reaching the `;' below the `case 3:'...

Are you kidding me?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
