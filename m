Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271260AbRIHQbA>; Sat, 8 Sep 2001 12:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271265AbRIHQau>; Sat, 8 Sep 2001 12:30:50 -0400
Received: from spike.porcupine.org ([168.100.189.2]:1288 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S271260AbRIHQam>; Sat, 8 Sep 2001 12:30:42 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
In-Reply-To: <Pine.LNX.4.33.0109070942500.19950-100000@sphinx.mythic-beasts.com>
 "from Matthew Kirkwood at Sep 7, 2001 09:52:38 am"
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Date: Sat, 8 Sep 2001 12:31:02 -0400 (EDT)
Cc: Wietse Venema <wietse@porcupine.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010908163102.7B0DFBC072@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Kirkwood:
> On Thu, 6 Sep 2001, Wietse Venema wrote:
> 
> > If an MTA receives a delivery request for user@[ip.address] then
> > the MTA has to decide if it is the final destination. This is
> > required by the SMTP RFC.
> 
> Would it not suffice, in the common case, to check if the
> local address that the SMTP connection was accepted on is
> the same as the IP address in the email address?

That would not work with local mail submissions.  Mail may arrive
via channels other than SMTP, yet use addressing methods according
to Internet standards.

I thank those who made useful suggestions.

I apologize to those who mis-understood my question as a request
to have kernel programmers explain me the mail RFC standards.
I can RTFM the mail RFC standards just fine.

The other folks need to grow up a bit.

Over and out.

	Wietse
