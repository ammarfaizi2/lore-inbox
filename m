Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131326AbRAKWxh>; Thu, 11 Jan 2001 17:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130874AbRAKWx1>; Thu, 11 Jan 2001 17:53:27 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:44904
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S131326AbRAKWxN>; Thu, 11 Jan 2001 17:53:13 -0500
Date: Thu, 11 Jan 2001 23:53:05 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Hans Grobler <grobh@sun.ac.za>
Cc: "Karsten Hopp (Red Hat)" <Karsten.Hopp@sap.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-ac6: drivers/net/rcpci45.c typo
Message-ID: <20010111235305.D612@jaquet.dk>
In-Reply-To: <3A5D9F29.4274AD6B@sap.com> <Pine.LNX.4.30.0101111358140.30013-100000@prime.sun.ac.za> <20010111130632.H27620@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010111130632.H27620@jaquet.dk>; from rasmus@jaquet.dk on Thu, Jan 11, 2001 at 01:06:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 01:06:32PM +0100, Rasmus Andersen wrote:
> On Thu, Jan 11, 2001 at 01:59:31PM +0200, Hans Grobler wrote:
> > Yes we know about this one. This is a bug that was killed, and then came
> > back to life. We're still trying to figure out how... :)
> > 
> I feel that I must step up and claim responsibility here: The patch is
> mine and I apparently messed it up. I will get back with a better one
> this evening.

Hi again.

The attached patch is against ac6 and hopefully fixes the problems
reported (I personally inspected it to make sure that the rcpci45_pci_table
stuff was correct). An updated patch against 240p2 can be found at
www.jaquet.dk/kernel/patches/rcpci.patch.gz

<pause>

On closer look this patch (against ac6) might be a bit to large to 
post to linux-kernel. I will make it available at 
www.jaquet.dk/kernel/patches/rcpci.patch.ac6.gz instead.

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

If we do not succeed, then we run the risk of failure.
		-- Vice President Dan Quayle, to the Phoenix Republican
		   Forum, March 1990
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
