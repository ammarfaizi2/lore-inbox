Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262357AbRERPrn>; Fri, 18 May 2001 11:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262356AbRERPrd>; Fri, 18 May 2001 11:47:33 -0400
Received: from conn.mc.mpls.visi.com ([208.42.156.2]:32154 "HELO
	conn.mc.mpls.visi.com") by vger.kernel.org with SMTP
	id <S262357AbRERPrX>; Fri, 18 May 2001 11:47:23 -0400
Message-ID: <3B053E1E.CA57DC6A@steinerpoint.com>
Date: Fri, 18 May 2001 10:22:06 -0500
From: Al Borchers <alborchers@steinerpoint.com>
Reply-To: alborchers@steinerpoint.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, tytso@mit.edu,
        Peter Berger <pberger@brimson.com>, andrewm@uow.edu.au
Subject: Re: [patch] 2.4.0, 2.2.18: A critical problem with tty_io.c
In-Reply-To: <E150iOA-0006z3-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Add an 'owner' field to the objects we are using. Then we can lock the tty
> and the ldisc from the tyy_io code rather than in serial.c and friends. This
> removes the unload during open/close races we currently have in serial.c
> 
> Take a look at videodev.c for a fairly clear example.

Andrew Morton wrote:
> I have a work-in-non-progress here which addresses a few of
> these things.  It would be good if someone could review it
> and finish it off...

I will take a look.

-- Al
