Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbQLaXFV>; Sun, 31 Dec 2000 18:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQLaXFL>; Sun, 31 Dec 2000 18:05:11 -0500
Received: from mail.sonicity.com ([63.251.235.60]:30728 "HELO
	mail.sonicity.com") by vger.kernel.org with SMTP id <S129601AbQLaXFA>;
	Sun, 31 Dec 2000 18:05:00 -0500
Date: Sun, 31 Dec 2000 14:34:33 -0800 (PST)
From: Justin <keyser-lk@soze.net>
To: John Buswell <johnb@linuxcast.org>
Cc: Harald Welte <laforge@gnumonks.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: netfilter + 2.4.0-test10 causes connect:invalid argument
In-Reply-To: <20001231192213.C3307@coruscant.gnumonks.org>
Message-ID: <Pine.LNX.4.30.0012311432260.1633-100000@straylight.int.sonicity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2000, Harald Welte wrote:

> On Wed, Dec 27, 2000 at 11:12:18PM -0500, John Buswell wrote:
> > 1. running 2.4.0-test10 with netfilter/iptables 1.1.2 ping/telnet gives
> > you invalid argument when connecting to ports on local interfaces.
>
> This is a _very_ strange problem. Nobody has erver reported this behaviour
> to us (the netfilter developers).
>
> I've never heared about it and never encountered it by myself. Sounds like
> it is a configuration issue.

Are you sure lo is up and configured (and that there's a route to
127.0.0.1 in your routing table that goes through lo)?  I think this can
cause such a problem.


justin
-- 
I see dead people.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
