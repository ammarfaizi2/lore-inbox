Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135377AbRA1Puc>; Sun, 28 Jan 2001 10:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136590AbRA1PuM>; Sun, 28 Jan 2001 10:50:12 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:49675 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S135377AbRA1PuE>; Sun, 28 Jan 2001 10:50:04 -0500
Date: Sun, 28 Jan 2001 10:49:21 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
Message-ID: <20010128104921.C23716@alcove.wittsend.com>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010127151141.E8236@conectiva.com.br> <20511.980695218@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <20511.980695218@redhat.com>; from dwmw2@infradead.org on Sun, Jan 28, 2001 at 03:20:18PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 03:20:18PM +0000, David Woodhouse wrote:

> acme@conectiva.com.br said:
> >  Please send additions and corrections to me and I'll try to keep it
> > updated.

> Anything which uses sleep_on() has a 90% chance of being broken. Fix
> them all, because we want to remove sleep_on() and friends in 2.5.

	And friends meaning "interruptible_sleep_on"?  Great...  I've
got a driver with about a half a dozen of them.  Point me at the Doco
to fix please?

> --
> dwmw2

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
