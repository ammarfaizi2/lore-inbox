Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289694AbSA2O4d>; Tue, 29 Jan 2002 09:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289670AbSA2O4W>; Tue, 29 Jan 2002 09:56:22 -0500
Received: from chmls06.mediaone.net ([24.147.1.144]:53419 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S289667AbSA2O4U>; Tue, 29 Jan 2002 09:56:20 -0500
Date: Tue, 29 Jan 2002 09:40:39 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129094039.A10150@pimlott.ne.mediaone.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020129005155.A6726@pimlott.ne.mediaone.net> <E16VXxh-0003pj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16VXxh-0003pj-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 01:06:09PM +0000, Alan Cox wrote:
> Andrew wrote:
> > Two, Linus has argued that maintainers are his patch penguins;
> > whereas you favor a single integration point between the maintainers
> > and Linus.  This has advantages and disadvantages, but on the whole,
> > I think it is better if Linus works directly with subsystem
> 
> Perl I think very much shows otherwise.

I'm really not sure about this example.  I assume you mean Perl 5.
Last I checked, Perl didn't really operate the way Rob suggests.
There is a "patch pumpking", but he is more analogous to Linus than
to Alan.  In particular, Larry Wall does not review the pumpking's
work at all (he instead sets general direction and makes key design
decisions).  If Perl doesn't have the problems observed in Linux, I
think it is because 1) Perl is smaller, 2) Perl 5 is largely in
bug-fix mode, 3) Perl has a culture of accepting patches with less
scrutiny (without meaning this as a slam, I think you can see
evidence of this in the Perl 5 source base).

> When you have one or two integrators you have a single tree pretty
> much everyone builds new stuff from and which people maintain
> small diffs relative to. At the end of the day that ends up like
> the older -ac tree, and with the same conditions - notably that
> anything in it might be going to see /dev/null not Linus if its
> shown to be flawed or not done well.

There is an upper bound to the size of the delta one person can
maintain (well, assuming his goal is to sync those changes with
Linus).  Unless Linus's throughput increases dramatically, the
integrator's delta will grow until it reaches that bound.  At that
point, the integrator has to drop patches (or give up!).  How do you
get around this?

Andrew
