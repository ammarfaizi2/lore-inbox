Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSFGDYm>; Thu, 6 Jun 2002 23:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316619AbSFGDYl>; Thu, 6 Jun 2002 23:24:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63640 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316610AbSFGDYk>;
	Thu, 6 Jun 2002 23:24:40 -0400
Date: Thu, 06 Jun 2002 20:21:08 -0700 (PDT)
Message-Id: <20020606.202108.52904668.davem@redhat.com>
To: cfriesen@nortelnetworks.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CFFB9F8.54455B6E@nortelnetworks.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Your idea is totally useless for non-datagram sockets.
Only datagram sockets use the interfaces where you bump
the counters.

I don't like the patch, nor the idea behind it, at all.

