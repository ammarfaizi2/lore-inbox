Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131051AbQLGQhy>; Thu, 7 Dec 2000 11:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131047AbQLGQho>; Thu, 7 Dec 2000 11:37:44 -0500
Received: from hera.cwi.nl ([192.16.191.1]:49321 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131051AbQLGQh2>;
	Thu, 7 Dec 2000 11:37:28 -0500
Date: Thu, 7 Dec 2000 17:06:56 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Tigran Aivazian <tigran@veritas.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
Message-ID: <20001207170656.A23858@veritas.com>
In-Reply-To: <Pine.LNX.4.21.0012071007420.970-100000@penguin.homenet> <Pine.GSO.4.21.0012070709400.20144-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0012070709400.20144-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Dec 07, 2000 at 08:23:59AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 08:23:59AM -0500, Alexander Viro wrote:

> <looking at the truncate(2) manpage>
> Oh, lovely - where the hell had the following come from?
> % man truncate
> ...
>        EINVAL The  pathname  contains  a character with the high-
>               order bit set.
> ...
> Andries, would you mind removing that, erm, statement? I'm curious about
> its genesis - AFAIK we had 8bit-clean namei for ages (quite possibly since
> 0.01).

I removed it in man-pages-1.30.
Apparently you have an older version.
(1.31 has been released; expect 1.32 soon)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
