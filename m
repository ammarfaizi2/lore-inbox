Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261988AbRE2CLL>; Mon, 28 May 2001 22:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261992AbRE2CLB>; Mon, 28 May 2001 22:11:01 -0400
Received: from venus.postmark.net ([207.244.122.71]:61191 "HELO
	venus.postmark.net") by vger.kernel.org with SMTP
	id <S261988AbRE2CK6>; Mon, 28 May 2001 22:10:58 -0400
Message-ID: <20010529011152.9622.qmail@venus.postmark.net>
Mime-Version: 1.0
From: J Brook <jbk@postmark.net>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com
Subject: Re: Current tulip driver from 2.4.5 is plain broken
Date: Tue, 29 May 2001 01:11:52 +0000
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Jaegermann wrote:
> I mentioned that before but this should be stated clearly.  As far
> as I am concerned "Linux Tulip driver version 0.9.15-pre2 (May 16,
> 2001)", as used in 2.4.5 - and other kernels - is totally buggered.
> It comes up, and ethernet interfaces can be configured, but does
> not matter how I am playing with options I cannot get a single
> packet through.
> 
> Replacing it in 2.4.5 with "Linux Tulip driver version 0.9.14d 
> (April 3, 2001)", which I have handy, restores sanity immediately 
> and a network simply works without any heroic efforts.
> 
> My NIC is "Digital DS21143 Tulip rev 65 at 0x8800".  BTW - a
> version "tulip-1.1.7" from sourceforge behaves exactly like 
> 0.9.15-pre2.

 I see exactly the same (broken!) behaviour here. The last kernel
that
works for me in 2.4.4-ac6, which I'm running at the moment. All
subsequent -ac kernels and 2.4.5-pre4 and above are broken. I
reported
the bug last week. Quick system summary: RH7.1, Duron, KT133, Network
card chip "Digital 21041-AA". I get the same problem as above
(working
kernels set half-duplex, broken kernels set full-duplex). More
details
available on request, or at
http://boudicca.tux.org/hypermail/linux-kernel/2001week21/0278.html

  Thanks!

    John
----------------
jbk@postmark.net
