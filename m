Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTJJOvw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbTJJOvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:51:52 -0400
Received: from mout2.freenet.de ([194.97.50.155]:20388 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S262850AbTJJOvs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:51:48 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [2.6-test7] [bttv] lots of warning/error messages
Date: Fri, 10 Oct 2003 18:51:31 +0200
User-Agent: KMail/1.5.4
References: <200310091729.30465.mbuesch@freenet.de> <20031010090955.GE32386@bytesex.org>
In-Reply-To: <20031010090955.GE32386@bytesex.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310101851.43828.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 10 October 2003 11:09, Gerd Knorr wrote:
> > get lots of warning/error messages from the bttv driver.
> > Here are todays messages:
> >
> > Oct  9 15:51:13 lfs kernel: bttv0: skipped frame. no signal? high irq
> > latency? Oct  9 15:57:57 lfs kernel: bttv0: OCERR @ 1fd95000,bits: HSYNC
> > OFLOW OCERR*
>
> Hmm.  Is the signal good?

Hm, I think so. I never had problems with the signal quality
and it looks quite good.

The whole thing works with linux-2.4 and it worked with 2.6-test1.
As far as I remember the trouble started with test2. (I posted
to lkml after I first saw the trouble. The
crashes disappeared now, but the messages are still there.)

> > I'm using a preemptible kernel.
> > Should I try it again with preemptible disabled?
>
> I would be surprised if CONFIG_PREMPT on/off makes a difference, looks
> more like a hardware issue to me.  Neverless it's worth a try.

I disabled CONFIG_PREMPT and it still throws these messages.

>   Gerd

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
Animals on this machine: some GNUs and Penguin 2.6.0-test7

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/huOfoxoigfggmSgRAgFcAJ4r2nyywOx78fkPj+jAZUvuGO3BowCdGH3F
jSujCOIOkOEaC2zARuv2WtA=
=uIrj
-----END PGP SIGNATURE-----

