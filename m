Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132049AbQLPPNc>; Sat, 16 Dec 2000 10:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132048AbQLPPNN>; Sat, 16 Dec 2000 10:13:13 -0500
Received: from uucp.nl.uu.net ([193.79.237.146]:61842 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S129345AbQLPPNC>;
	Sat, 16 Dec 2000 10:13:02 -0500
Date: Sat, 16 Dec 2000 15:32:02 +0100 (CET)
From: kees <kees@schoen.nl>
To: Dima Brodsky <dima@cs.ubc.ca>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Sound (emu10k1) broken in 2.2.18
In-Reply-To: <20001215215031.A743@cascade.cs.ubc.ca>
Message-ID: <Pine.LNX.4.21.0012161531080.2084-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have reported the same experience some days ago. I have a second machine
with a es1371 this also fails.

Kees

On Fri, 15 Dec 2000, Dima Brodsky wrote:

> Hi,
> 
> The sound (emu10k1) seems to be broken under 2.2.18.
> If I do:
> 
> 	cat x > /dev/dsp
> 
> I get:
> 
> 	bash: /dev/dsp: No such device
> 
> But an ls -l shows:
> 
> crw-rw-rw-   1 root     sys       14,   3 Dec 15 21:25 dsp
> crw-rw-rw-   1 root     sys       14,  19 Dec 15 21:25 dsp1
> 
> Same thing with xmms and mpg123.  There were no problems under 2.2.17.
> 
> Thanks
> ttyl
> Dima
> 
> -- 
> Dima Brodsky                                   dima@cs.ubc.ca
>                                                http://www.cs.ubc.ca/~dima
> 201-2366 Main Mall                             (604) 822-6179 (Office)
> Department of Computer Science                 (604) 822-2895 (DSG Lab)
> University of British Columbia, Canada         (604) 822-5485 (FAX)
> 
> Computers are like Old Testament gods; lots of rules and no mercy.
> 							  (Joseph Campbell)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
