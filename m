Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbRANLh7>; Sun, 14 Jan 2001 06:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130374AbRANLht>; Sun, 14 Jan 2001 06:37:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11931 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129777AbRANLhk>;
	Sun, 14 Jan 2001 06:37:40 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14945.36695.669979.754755@pizda.ninka.net>
Date: Sun, 14 Jan 2001 03:36:55 -0800 (PST)
To: Andi Kleen <ak@suse.de>
Cc: Igmar Palsenberg <i.palsenberg@jdimedia.nl>,
        Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + iproute2
In-Reply-To: <20010114123310.A23011@gruyere.muc.suse.de>
In-Reply-To: <14945.26991.35849.95234@pizda.ninka.net>
	<Pine.LNX.4.30.0101141013080.16469-100000@jdi.jdimedia.nl>
	<14945.28354.209720.579437@pizda.ninka.net>
	<20010114115215.A22550@gruyere.muc.suse.de>
	<14945.34208.281500.226085@pizda.ninka.net>
	<20010114123310.A23011@gruyere.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > How would you pass the extended errors? As strings or as to be
 > defined new numbers? I would prefer strings, because the number
 > namespace could turn out to be as nasty to maintain as the current
 > sysctl one.

Textual error messages for system calls never belong in the kernel.
Put it in glibc or wherever.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
