Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136721AbREAVAD>; Tue, 1 May 2001 17:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136722AbREAU7x>; Tue, 1 May 2001 16:59:53 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:58130 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136721AbREAU7n>; Tue, 1 May 2001 16:59:43 -0400
Date: Tue, 1 May 2001 13:59:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>, <Andries.Brouwer@cwi.nl>
Subject: Re: iso9660 endianness cleanup patch
In-Reply-To: <3AEEFD7F.3E7C6B3@transmeta.com>
Message-ID: <Pine.LNX.4.31.0105011358220.2667-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 May 2001, H. Peter Anvin wrote:
>
> Oh bother, you're right of course.  We need some kind of standardized
> macro for indirecting through a potentially unaligned pointer.

No we don't - because it already exists.

It's called "get_unaligned()".

		Linus

