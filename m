Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273515AbRI3SLt>; Sun, 30 Sep 2001 14:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRI3SLj>; Sun, 30 Sep 2001 14:11:39 -0400
Received: from [208.129.208.52] ([208.129.208.52]:18442 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S273515AbRI3SL2>;
	Sun, 30 Sep 2001 14:11:28 -0400
Date: Sun, 30 Sep 2001 11:16:13 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tcp_v4_get_port() and ephemeral ports
In-Reply-To: <3BB75EB4.3268D3FC@kegel.com>
Message-ID: <Pine.LNX.4.40.0109301114390.7223-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Sep 2001, Dan Kegel wrote:

> I'm doing ftp server benchmarking, doing lots of connect()'s.
> Since ports aren't supposed to be reused for 2MSL (theoretically 120 seconds),
> the absolute limit on connections per second is 64K/120 = 500.
> This actually could pose a problem for me.  (Yeah, 2MSL is
> set to 30 seconds in linux, so the problem isn't as severe
> as the standard says, but it's still a problem.)

net.ipv4.tcp_tw_recycle=1
net.ipv4.tcp_fin_timeout=8

ONLY FOR TESTING !! :)



- Davide


