Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285183AbRLFUq5>; Thu, 6 Dec 2001 15:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284237AbRLFUpW>; Thu, 6 Dec 2001 15:45:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45065 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284246AbRLFUn5>; Thu, 6 Dec 2001 15:43:57 -0500
Date: Thu, 6 Dec 2001 12:37:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <E16C43U-0002in-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112061236050.10877-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Dec 2001, Alan Cox wrote:
>
> The internal representation is kdev_t, which wants to turn into a pointer

No.

That kdev_t has been around for years, and is going away. In 2.6 there
will _be_ no kdev_t.

There is "struct block_device" for internal stuff, and "dev_t" for
external stuff. The first one is a real structure, the second one is just
a cookie.

		Linus

