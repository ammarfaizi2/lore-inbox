Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271594AbRIFRp1>; Thu, 6 Sep 2001 13:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271578AbRIFRpK>; Thu, 6 Sep 2001 13:45:10 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:1803 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S271592AbRIFRox>;
	Thu, 6 Sep 2001 13:44:53 -0400
Date: Thu, 6 Sep 2001 11:45:12 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
Message-ID: <20010906114512.A17941@qcc.sk.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E15f2WT-0008Tp-00@the-village.bc.nu> <20010906172316.E0B74BC06C@spike.porcupine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010906172316.E0B74BC06C@spike.porcupine.org>; from wietse@porcupine.org on Thu, Sep 06, 2001 at 01:23:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wietse Venema <wietse@porcupine.org> wrote:
> Alan Cox:
> > How for example do you propose to answer the question for the case
> > Q: "is this local" A: "it depends on the sender"
> > With netfilter and transparent proxying active this is entirely possible
> 
> Please explain the relevance for a real-world, SMTP based, MTA.
> 
> If an MTA receives a delivery request for user@[ip.address] then
> the MTA has to decide if it is the final destination. This is
> required by the SMTP RFC.
> 
> In order to enable SMTP RFC compliance, Linux has to provide the
> MTA with the necessary information.  Requiring the sysadmin to
> enumerate all IP addresses in a file, as suggested by some other
> poster, is impractical.

I was that other poster.  Typing "is impractical" into your MUA doesn't
make it a fact.  It's not only a very practical solution, it's the
_most_ practical solution.

As other posters have noted, there's no magic incantation to tell you
which IP addresses happen to have an smtpd listening which are the
self-same MTA.  The only person who's going to have this information is
the administrator.

Why are you afraid to ask the mail administrator to do configuration of
the MTA?  Are you afraid they're idiots?

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
