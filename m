Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262675AbSIPRSp>; Mon, 16 Sep 2002 13:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262687AbSIPRSp>; Mon, 16 Sep 2002 13:18:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:64906 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262675AbSIPRSo>; Mon, 16 Sep 2002 13:18:44 -0400
Date: Mon, 16 Sep 2002 13:26:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: tomc@teamics.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem:  RFC1166 addressing
In-Reply-To: <OF298A60D6.2FD15C58-ON86256C36.005B260E@teamics.com>
Message-ID: <Pine.LNX.3.95.1020916131714.23886A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2002 tomc@teamics.com wrote:

> RFC 1166 states that:
> 
> 
>  The class A network number 127 is assigned the "loopback"
>          function, that is, a datagram sent by a higher level protocol
>          to a network 127 address should loop back inside the host.  No
>          datagram "sent" to a network 127 address should ever appear on
>          any network anywhere.

I haven't tested this <yet>, but this is not mandatory because the
standard says "should". I know that some older versions of SunOs would
"announce" when they saw such an address on the wire. This was once
found to come from an incorrectly-configured INTERACTIVE Unix machine
here.

You will need root privs to use `ifconfig` and the same to write
raw packets from user-mode so I don't think you have a problem
with the kernel not, as you say, enforcing the standard. Of course,
of everybody has root, then they can do anything regardless of any
kernel enforcement. Just write raw packets claiming you are from
whitehouse.gov and you can rule the universe.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

