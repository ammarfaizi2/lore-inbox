Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267808AbTAHOeq>; Wed, 8 Jan 2003 09:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267813AbTAHOeq>; Wed, 8 Jan 2003 09:34:46 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:27307 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S267808AbTAHOeq>; Wed, 8 Jan 2003 09:34:46 -0500
Date: Wed, 8 Jan 2003 15:43:27 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: netdev@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: Re: ipv6 stack seems to forget to send ACKs
In-Reply-To: <20030108130850.GQ22951@wiggy.net>
Message-ID: <Pine.LNX.4.44.0301081535460.27551-100000@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had no problems listening to the stream, except a gap after about 3mins.
tcpdump showed the client closed the connection, and quickly initiated a
new one. Since then i had 15mins of nonstop playback and it stopped,
similarily to your dump.

The tcpdump is similar to yours, except i do not have traffic class info.
And rarely sack was used.

Is there a ip6 mangling router in your route to the icecast server?

I have been listening on an ip6 enabled host behind my ip6 tunnelling
router to my MAN.

Client: linux-2.4.21-pre1
Router: linux-2.4.20-grsec

I have to go now, i will look into that later.

Regards,
Maciej


