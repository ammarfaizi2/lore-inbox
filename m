Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQL2QZP>; Fri, 29 Dec 2000 11:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131436AbQL2QZF>; Fri, 29 Dec 2000 11:25:05 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24131 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129828AbQL2QYq>; Fri, 29 Dec 2000 11:24:46 -0500
Date: Fri, 29 Dec 2000 16:53:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Petru Paler <ppetru@ppetru.net>
Cc: Jure Pecar <pegasus@telemach.net>, linux-kernel@vger.kernel.org,
        thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001229165340.C12791@athlon.random>
In-Reply-To: <3A4BE9B0.5C809AAC@telemach.net> <20001229032953.A9810@athlon.random> <20001229034712.B9810@athlon.random> <20001229093840.A792@ppetru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001229093840.A792@ppetru.net>; from ppetru@ppetru.net on Fri, Dec 29, 2000 at 09:38:40AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 09:38:40AM +0200, Petru Paler wrote:
> This is one of the main thttpd design points: run in a select() loop. Since
> it is intended for mainly static workloads, it performs quite well...

It can't scale in SMP.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
