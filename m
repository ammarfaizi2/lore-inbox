Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289972AbSA3QWR>; Wed, 30 Jan 2002 11:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289918AbSA3QVW>; Wed, 30 Jan 2002 11:21:22 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:51901 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289968AbSA3QT6>; Wed, 30 Jan 2002 11:19:58 -0500
Date: Wed, 30 Jan 2002 18:14:53 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP/IP Speed
In-Reply-To: <Pine.LNX.3.95.1020130110350.15189A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0201301813310.5518-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Richard B. Johnson wrote:

> 
> When I ping two linux machines on a private link, I get 0.1 ms delay.
> When I send large TCP/IP stream data between them, I get almost
> 10 megabytes per second on a 100-base link. Wonderful.
> 
> However, if I send 64 bytes from one machine and send it back, simple
> TCP/IP strean connection, it takes 1 millisecond to get it back? There
> seems to be some artifical delay somewhere.  How do I turn this OFF?

I would say its all in the TCP connection initiation (socket(), create() 
etc...)

Cheers,
	Zwane Mwaikambo


