Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSEUXPY>; Tue, 21 May 2002 19:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316776AbSEUXPX>; Tue, 21 May 2002 19:15:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52236 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316772AbSEUXPV> convert rfc822-to-8bit; Tue, 21 May 2002 19:15:21 -0400
Date: Tue, 21 May 2002 16:15:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
In-Reply-To: <Pine.LNX.4.33.0205211557410.1307-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0205211614200.15094-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g4LNFBj05289
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 May 2002, Linus Torvalds wrote:
> 
> Applied. Nothing needed but some time for me to look through it.

Well, I may have to revert that.

	mm/mm.o: In function `rw_swap_page':
	mm/mm.o(.text+0xaeb2): undefined reference to `suspend_device'

Please send me a fix asap.

		Linus

