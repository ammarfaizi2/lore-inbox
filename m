Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264062AbRFPX5W>; Sat, 16 Jun 2001 19:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbRFPX5M>; Sat, 16 Jun 2001 19:57:12 -0400
Received: from sense-robertk-129.oz.net ([216.39.160.129]:13442 "HELO
	mail.kleemann.org") by vger.kernel.org with SMTP id <S264062AbRFPX46>;
	Sat, 16 Jun 2001 19:56:58 -0400
Date: Sat, 16 Jun 2001 16:56:55 -0700 (PDT)
From: Robert Kleemann <robert@kleemann.org>
X-X-Sender: <robert@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <Pine.LNX.4.33.0106121720310.1152-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0106161643560.1137-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to figure out what this problem is I'm going to add some
printk statements in the networking code on the client machine.
Hopefully, this will show me what's going on.  My goal is to trace the
receipt of the datagram by tcp, see why/how it's deciding to ack or
not ack, and then trace the sending of the ack.

There are quite a few files that seem to be involved including:
linux/net/ipv4/tcp*.c as well as some important structures in
linux/include/net/sock.h

I'm guessing this is going to take me a while just to figure out where
to look and what to look for.  Can any of you networking gurus save me
some time and suggest some functions to start looking at?

thanx!
Robert

