Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263600AbREYHC7>; Fri, 25 May 2001 03:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263601AbREYHCj>; Fri, 25 May 2001 03:02:39 -0400
Received: from mail.kdt.de ([195.8.224.4]:50693 "EHLO mail.kdt.de")
	by vger.kernel.org with ESMTP id <S263600AbREYHCh>;
	Fri, 25 May 2001 03:02:37 -0400
Mail-Copies-To: never
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, adam@yggdrasil.com,
        linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
In-Reply-To: <20010524234240.G23155@vitelus.com>
From: Andreas Jaeger <aj@suse.de>
Date: 25 May 2001 09:02:01 +0200
In-Reply-To: <20010524234240.G23155@vitelus.com> (Aaron Lehmann's message of "Thu, 24 May 2001 23:42:40 -0700")
Message-ID: <u8r8xd3o9i.fsf@gromit.moeb>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann <aaronl@vitelus.com> writes:

> On Fri, May 25, 2001 at 02:34:05AM -0400, Alexander Viro wrote:
> > Should we file bug reports against glibc?
> 
> invsqrtpi=  5.64189583547756279280e-01
> Inverted square root of pi. Want to file a bug on Pi?
> 
> tpi      =  6.36619772367581382433e-01,
> R0/S0 on [0, 2.00]
> 
> I'm not sure what R and S are, but the glibc developers probably are.

We have comments in the code that state how j0 is build, and R0/S0
come from some expansion:
 * Bessel function of the first and second kinds of order zero.
 * Method -- j0(x):
 *	1. For tiny x, we use j0(x) = 1 - x^2/4 + x^4/64 - ...
 *	2. Reduce x to |x| since j0(x)=j0(-x),  and
 *	   for x in (0,2)
 *		j0(x) = 1-z/4+ z^2*R0/S0,  where z = x*x;
 *	   (precision:  |j0-1+z/4-z^2R0/S0 |<2**-63.67 )

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
