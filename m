Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131254AbQLLL1x>; Tue, 12 Dec 2000 06:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131265AbQLLL1n>; Tue, 12 Dec 2000 06:27:43 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:22362 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S131254AbQLLL1c>; Tue, 12 Dec 2000 06:27:32 -0500
Date: Tue, 12 Dec 2000 22:23:13 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stephen Rothwell <sfr@linuxcare.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre21 oops reading /proc/apm
In-Reply-To: <Pine.LNX.4.05.10012121332300.25479-200000@marina.lowendale.com.au>
Message-ID: <Pine.LNX.4.05.10012122203130.26037-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2000, Neale Banks wrote:

[...]
> Diff against unmolested 2.2.18pre24 is attached.

Hold that one, I just found another case I haven't covered: booting with
apm=debug causes oops and nukes the bootup.  Reading the source, I can't
see how this doesn't also affect the "dell_crap" case too.

New diff to follow, hopefully tomorrow.

Neale.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
