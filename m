Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270704AbRHNSvx>; Tue, 14 Aug 2001 14:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270705AbRHNSvo>; Tue, 14 Aug 2001 14:51:44 -0400
Received: from net2.ameuro.de ([62.208.90.8]:43234 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id <S270704AbRHNSva>;
	Tue, 14 Aug 2001 14:51:30 -0400
Date: Tue, 14 Aug 2001 20:51:01 +0200
From: Anders Larsen <anders@alarsen.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: PinkFreud <pf-kernel@mirkwood.net>, linux-kernel@vger.kernel.org
Subject: Re: Are we going too fast?
Message-ID: <20010814205101.A11997@errol.alarsen.net>
In-Reply-To: <Pine.LNX.4.20.0108130303120.1037-100000@eriador.mirkwood.net> <E15WHVE-0007N6-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E15WHVE-0007N6-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Aug 13, 2001 at 15:11:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-08-13 15:11 Alan Cox wrote:
> > emergency sync) when attempting to use 'ls' on a mounted QNX filesystem
> > (ls comes up fine, then system crashes - nothing sent to syslog, no errors
> > on screen, nothing!) - and this latest is with 2.4.8!
> 
> The qnxfs code is experimental - so I can believe it might fail in 2.4. I'd
> be very interested in info on that one.

The qnxfs code is really quite stable - that's the first time in more than a
year that I hear of any problem reading a qnx file-system; actually, I've been
considering removing the 'experimental' tag, but now I'll reconsider...

Incidentally, I use the qnxfs in a production environment here (tried'em all
up to 2.4.7 - guess I'll better switch to 2.4.8 right now to check, although
the qnxfs code has not changed from 2.4.7)

I'll be very interested in hearing what you find out.

cheers
  Anders (maintainer, qnx4fs)
-- 
"In theory there is no difference between theory and practice.
 In practice there is." - Yogi Berra
