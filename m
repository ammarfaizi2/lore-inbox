Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262693AbSIPRU5>; Mon, 16 Sep 2002 13:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbSIPRU5>; Mon, 16 Sep 2002 13:20:57 -0400
Received: from h66-38-216-165.gtconnect.net ([66.38.216.165]:59144 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S262693AbSIPRU4>;
	Mon, 16 Sep 2002 13:20:56 -0400
Date: Mon, 16 Sep 2002 13:25:54 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: tomc@teamics.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem:  RFC1166 addressing
In-Reply-To: <OF298A60D6.2FD15C58-ON86256C36.005B260E@teamics.com>
Message-ID: <Pine.LNX.4.44.0209161323500.21210-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2002 tomc@teamics.com wrote:

> Date: Mon, 16 Sep 2002 11:50:36 -0500
> From: tomc@teamics.com
> To: linux-kernel@vger.kernel.org
> Subject: Problem:  RFC1166 addressing
>
> RFC 1166 states that:
>
>
>  The class A network number 127 is assigned the "loopback"
>          function, that is, a datagram sent by a higher level protocol
>          to a network 127 address should loop back inside the host.  No
>          datagram "sent" to a network 127 address should ever appear on
>          any network anywhere.
>
>  Linux does not enforce this.  I have uncovered some users using this
> function to attempt to circumvent the firewall.  I am able to "create" 127
> network traffic as follows:
>
> Machine 1:   ifconfig eth0:1 127.1.2.3   [ running kernel 2.2.14 ]
>
> Machine 2:   ifconfig eth0:1 127.1.2.4  [ running kernel 2.4.19 ]
>
> Machine 2:  ping 127.1.2.3
>
> Packets move between the hosts.    Also seems to work on Macintosh.


I would call that a bug in the firewall rules.  Depending on the hosts to
behave in such a way as to make life easier for the firewall makes for a
losing proposition.

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

