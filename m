Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262236AbRERCiN>; Thu, 17 May 2001 22:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262238AbRERCiD>; Thu, 17 May 2001 22:38:03 -0400
Received: from corb.mc.mpls.visi.com ([208.42.156.1]:214 "HELO
	corb.mc.mpls.visi.com") by vger.kernel.org with SMTP
	id <S262236AbRERChy>; Thu, 17 May 2001 22:37:54 -0400
Message-ID: <3B048518.705AC5F3@steinerpoint.com>
Date: Thu, 17 May 2001 21:12:40 -0500
From: Al Borchers <alborchers@steinerpoint.com>
Reply-To: alborchers@steinerpoint.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, tytso@mit.edu,
        Peter Berger <pberger@brimson.com>
Subject: Re: [patch] 2.4.0, 2.2.18: A critical problem with tty_io.c
In-Reply-To: <E150VEu-0006AM-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> It has to be changed, the race is basically unfixable any other way. I didn't
> lightly make that change

I agree.  The patch seems like the correct solution.  What will it take to
get the patch in the 2.4.x kernels?  Do we need someone to go through the serial
drivers and fix their open/close routines to work with this patch?  Peter
and I can take some time to do that--if that would help.

-- Al
