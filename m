Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132501AbRDKAlE>; Tue, 10 Apr 2001 20:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132502AbRDKAkz>; Tue, 10 Apr 2001 20:40:55 -0400
Received: from monza.monza.org ([209.102.105.34]:13843 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S132501AbRDKAko>;
	Tue, 10 Apr 2001 20:40:44 -0400
Date: Tue, 10 Apr 2001 17:40:05 -0700
From: Tim Wright <timw@splhi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
Message-ID: <20010410161524.B1722@kochanski>
Reply-To: timw@splhi.com
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	David Howells <dhowells@cambridge.redhat.com>,
	Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0104101229150.13071-100000@penguin.transmeta.com> <E14n68O-0005IF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14n68O-0005IF-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 10, 2001 at 10:57:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sequent Symmetry machinses supported SMP on i486 and even i386 going back
to the original 16MHz 386 processors. You could put up to 30 in a system.
I do not, however, envisage anyone porting Linux to these any time soon.
The hardware is just too "unusual" for it to be feasible. The later Symmetry
5000 machines might be slightly more practical, but I'm not sure if you'd have
room in your new house for one. You could probably do without central heating
if we did send you one :-)

Tim

On Tue, Apr 10, 2001 at 10:57:09PM +0100, Alan Cox wrote:
> > That's no problem if we make this SMP-specific - I doubt anybody actually
> > uses SMP on i486's even if the machines exist, as I think they all had
> 
> They do. There are two (total world wide) 486 SMP users I know about and they
> mostly do it to be awkward ;)
> 
> > special glue logic that Linux would have trouble with anyway. But the
> 
> The Compaqs were custom, the non Compaq ones included several using Intel
> MP 1.1.
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
