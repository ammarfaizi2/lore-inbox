Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282939AbRK0Uni>; Tue, 27 Nov 2001 15:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282938AbRK0Un2>; Tue, 27 Nov 2001 15:43:28 -0500
Received: from chmls06.mediaone.net ([24.147.1.144]:11137 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S282939AbRK0UnO>; Tue, 27 Nov 2001 15:43:14 -0500
From: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Date: Tue, 27 Nov 2001 15:31:19 -0500
To: arjan@fenrus.demon.nl
Cc: Heikki Levanto <heikki@indexdata.dk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.16: "Address family not supported" on RH IBM T23
Message-ID: <20011127153119.A25554@pimlott.ne.mediaone.net>
Mail-Followup-To: arjan@fenrus.demon.nl,
	Heikki Levanto <heikki@indexdata.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <20011127200522.B27480@indexdata.dk> <m168nl3-000OVrC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m168nl3-000OVrC@amadeus.home.nl>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 07:19:05PM +0000, arjan@fenrus.demon.nl wrote:
> You need to enable the netlink config options
> 
> your problem; it's even mentioned in the releasenotes..

It would be even better to mention it in the kernel documentation,
since iproute2 is fairly standard now.  I'm really not enough of a
kernel hacker to change it, but the current Configure.help entry for
CONFIG_NETLINK suggests that it is useful only for relatively
obscure applications.

    You need to say Y here to use the tools in the iproute2 package
    (<ftp://ftp.inr.ac.ru>).

And is CONFIG_RTNETLINK also necessary for ip?

Andrew
