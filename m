Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271599AbRIGHfD>; Fri, 7 Sep 2001 03:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271598AbRIGHex>; Fri, 7 Sep 2001 03:34:53 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:35590 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271599AbRIGHem>; Fri, 7 Sep 2001 03:34:42 -0400
Date: Fri, 7 Sep 2001 09:35:00 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org, Wietse Venema <wietse@porcupine.org>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
Message-ID: <20010907093500.A6429@emma1.emma.line.org>
Reply-To: /dev/null@emma1.emma.line.org
Mail-Followup-To: /dev/null@emma1.emma.line.org
In-Reply-To: <20010906212303.A23595@castle.nmd.msu.ru> <20010906173948.502BFBC06C@spike.porcupine.org> <20010906235157.D11046@mea-ext.zmailer.org> <20010907112935.A26353@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010907112935.A26353@castle.nmd.msu.ru>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Sep 2001, Andrey Savochkin wrote:

> > 	[ This is one of (at least) three different things that
> > 	  have been mentioned in this thread, but lets limit
> > 	  into only this one thing in this email ...  ]
> > 
> > 	Why that needs a list of all addresses in the system ?
> > 
> > 	Reception can query with standard BSD API what is
> > 	the local address of the socket _at_the_moment_ at
> > 	receiving side.  (  getsockname()  )
> > 
> > 	Is there, really, any reason to detect locally anything else ?
> 
> The question is about what to do if you got a message to root@[10.0.0.1]
> through a socket with local address (getsockname()) being 192.193.194.165.
> If the local address is 10.0.0.1 also, there is no problem, the message is
> clearly for your MTA.

Stop this pointless loop detection discussion, or take it off list and
me of the Cc: please.
