Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262941AbTDBUuF>; Wed, 2 Apr 2003 15:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262961AbTDBUuF>; Wed, 2 Apr 2003 15:50:05 -0500
Received: from chaos.analogic.com ([204.178.40.224]:49814 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262941AbTDBUuE>; Wed, 2 Apr 2003 15:50:04 -0500
Date: Wed, 2 Apr 2003 16:03:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Dennis Cook <cook@sandgate.com>
cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Deactivating TCP checksumming
In-Reply-To: <b6fi8m$j4g$1@main.gmane.org>
Message-ID: <Pine.LNX.4.53.0304021555160.32710@chaos>
References: <F91mkXMUIhAumscmKC00000f517@hotmail.com>
 <20030401122824.GY29167@mea-ext.zmailer.org> <b6fda2$oec$1@main.gmane.org>
 <20030402203653.GA2503@gtf.org> <b6fi8m$j4g$1@main.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Dennis Cook wrote:

> What I was looking for is a general capability to keep the SW transport
> stack from
> computing outgoing TCP/UDP/IP checksums so that the HW can be allowed to do
> it,
> similar to Windows checksum offload capability.
REALLY? Who are you kidding. Windows has no such capability.

Check \WINDOWS\SYSTEM32\DRIVERS\ETC\* and see who they stole
the TCP/IP stack from!

Further, when you perform normal user->TCP/IP operations, you
get checksumming for free as part of the copy operation. It's
only when you don't even copy data that you can get any advantage
of not checksumming. That's why sendfile disables it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

