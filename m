Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130836AbRAWQUt>; Tue, 23 Jan 2001 11:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131066AbRAWQU3>; Tue, 23 Jan 2001 11:20:29 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:2961 "EHLO tux.rsn.hk-r.se")
	by vger.kernel.org with ESMTP id <S130836AbRAWQU2>;
	Tue, 23 Jan 2001 11:20:28 -0500
Date: Tue, 23 Jan 2001 17:18:38 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Daniel Stone <daniel@kabuki.eyep.net>
cc: Aaron Lehmann <aaronl@vitelus.com>, Rusty Russell <rusty@linuxcare.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and ipmasq modules
In-Reply-To: <E14Kxtc-0000KT-00@kabuki.eyep.net>
Message-ID: <Pine.LNX.4.21.0101231716160.11282-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jan 2001, Daniel Stone wrote:

[snip]
> > -:- DCC GET request from aaronl_[aaronl@vitelus.com
> >           [64.81.36.147:33989]] 150 bytes /* That's the NAT box's IP */
> > -:- DCC Unable to create connection: Connection refused
> > 
> > Any idea what's wrong? I have irc-conntrack-nat compiled into the
> > kernel.
> 
> 
> Well, it's NAT'ing it OK. Are you sure you have a rule like the
> following:
> iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
> ?
> 
> d
> 
> PS: If you're trying to NAT a DCC RESUME, don't even bother.

DCC Resume works fine here behind a NAT-box running 2.4

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
