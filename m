Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290276AbSA3Rgs>; Wed, 30 Jan 2002 12:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290115AbSA3RfY>; Wed, 30 Jan 2002 12:35:24 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:56513 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289987AbSA3QhC>; Wed, 30 Jan 2002 11:37:02 -0500
Date: Wed, 30 Jan 2002 18:31:57 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP/IP Speed
In-Reply-To: <Pine.LNX.3.95.1020130113133.15383A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0201301831120.5518-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Richard B. Johnson wrote:

> But it's already connected.
> 
> 
>          host:
>          for (;;) {
>             gettimeofday(...);
>             write(s, buf, 64);
>             read(s, buf, sizeof(buffer));
>             gettimeofday(...);
>          /* delay is 1.0 ms */
>          }
>          server is IPPORT_ECHO

You didn't make that explicit in your previous email, and anyway what kind 
of resolution can you expect from gettimeofday...

Cheers,
	Zwane Mwaikambo


