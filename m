Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129476AbQLAUNs>; Fri, 1 Dec 2000 15:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129571AbQLAUNj>; Fri, 1 Dec 2000 15:13:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14099 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129476AbQLAUN2>; Fri, 1 Dec 2000 15:13:28 -0500
Date: Thu, 30 Nov 2000 18:17:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre24
Message-ID: <20001130181740.A18566@athlon.random>
In-Reply-To: <E140wh7-0005Na-00@the-village.bc.nu> <20001129150159.Y872@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001129150159.Y872@opus.bloom.county>; from trini@kernel.crashing.org on Wed, Nov 29, 2000 at 03:01:59PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2000 at 03:01:59PM -0700, Tom Rini wrote:
> As Dave Miller pointed out, DEV_MAC_HID sysctl conflicts with the RAID patches

That's right but OTOH I'd simply declare the sysctl-by-number interface dead
for new introduced sysctl. We need to preserve backwards compatibility of
course but that's not a problem. I'd preferred if we killed it completly (just
providing backwards compatibility) during the 2.4.x cycle. Only reliable
way to use new sysctl is sysctl-by-name IMHO.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
