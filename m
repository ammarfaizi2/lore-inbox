Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268160AbRGWJKn>; Mon, 23 Jul 2001 05:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268161AbRGWJKd>; Mon, 23 Jul 2001 05:10:33 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:9063 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S268160AbRGWJKZ>;
	Mon, 23 Jul 2001 05:10:25 -0400
Date: Mon, 23 Jul 2001 10:12:19 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
To: Ian Chilton <ian@ichilton.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: OT: Journaling FS Comparison
In-Reply-To: <20010722162150.A23381@woody.ichilton.co.uk>
Message-ID: <Pine.LNX.4.21.0107231004080.612-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 22 Jul 2001, Ian Chilton wrote:
> With there been 4 of them (ext3, reiserfs, XFS and JFS),
> it's not an easy choice for anyone.

at the time when I did the comparison using SPEC SFS to benchmark, the
choice was not hard at all -- absolute and obvious winner was reiserfs.
That is, amongst the freely available ones. (this was not too long ago, a
mere 2 months or so).

However, if you are willing to pay for your filesystem, our vxfs beats all
of the above at _very_ (very) high loads (loads unreachable by any other
filesystem so far ;) in both performance and stability. (well, it beats
them in most situations at low loads as well but that is not interesting)

It should be available to our beta-customers via www.veritas.com
somewhere...

Regards,
Tigran

