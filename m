Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281599AbRK0RE5>; Tue, 27 Nov 2001 12:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281609AbRK0REo>; Tue, 27 Nov 2001 12:04:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19972 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281599AbRK0REb>; Tue, 27 Nov 2001 12:04:31 -0500
Date: Tue, 27 Nov 2001 08:58:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <rwhron@earthlink.net>
cc: <linux-kernel@vger.kernel.org>, <ltp-list@lists.sourceforge.net>,
        <andrea@suse.de>
Subject: Re: VM tests on 5 recent kernels
In-Reply-To: <20011127021513.A228@earthlink.net>
Message-ID: <Pine.LNX.4.33.0111270853460.1860-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Nov 2001 rwhron@earthlink.net wrote:
> 2.4.16		mp3 played 312 of 371 seconds 84%
> 2.5.1-pre1		mp3 played 361 of 365 seconds 99%

Interesting. I thought those two were basically identical VM-wise, so the
variance seems to be due to variance in the VM itself, not so much between
VM's.

The other numbers (ie total time etc) are fairly close, but the mp3
playing percentage seems to be inherently "unstable". Which is really
interesting in itself.

What happens to the MP3 numbers if you run it a few times on the exact
same kernel?

		Linus

