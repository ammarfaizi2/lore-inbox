Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132141AbQL2TpM>; Fri, 29 Dec 2000 14:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132136AbQL2TpC>; Fri, 29 Dec 2000 14:45:02 -0500
Received: from Cantor.suse.de ([194.112.123.193]:5636 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132110AbQL2Toy>;
	Fri, 29 Dec 2000 14:44:54 -0500
Date: Fri, 29 Dec 2000 20:14:25 +0100
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Petru Paler <ppetru@ppetru.net>,
        Jure Pecar <pegasus@telemach.net>, linux-kernel@vger.kernel.org,
        thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001229201425.A3741@gruyere.muc.suse.de>
In-Reply-To: <20001229165340.C12791@athlon.random> <E14C4bd-0005bM-00@the-village.bc.nu> <20001229200657.B16261@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001229200657.B16261@athlon.random>; from andrea@suse.de on Fri, Dec 29, 2000 at 08:06:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 08:06:57PM +0100, Andrea Arcangeli wrote:
> On Fri, Dec 29, 2000 at 06:50:18PM +0000, Alan Cox wrote:
> > Your cgi will keep the other CPU occupied, or run two of them. thttpd has
> > superb scaling properties compared to say apache.
> 
> I think with 8 CPUs and 8 NICs (usual benchmark setup) you want more than 1 cpu

That's a good benchmark setup when the benchmark requires a single machine.

In the real world it often makes a lot of sense though to use a cluster
of cheap single CPU machines behind a load balancer (gives you better fault 
tolerance and is likely cheaper) 

For these thttpd is a nice web server.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
