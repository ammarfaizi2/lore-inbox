Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKPXEz>; Thu, 16 Nov 2000 18:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130540AbQKPXEp>; Thu, 16 Nov 2000 18:04:45 -0500
Received: from 62-6-231-42.btconnect.com ([62.6.231.42]:29575 "EHLO
	saturn.homenet") by vger.kernel.org with ESMTP id <S129183AbQKPXEd>;
	Thu, 16 Nov 2000 18:04:33 -0500
Date: Thu, 16 Nov 2000 22:31:28 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: "SubmittingPatches" text
In-Reply-To: <E13wX8W-0008Qt-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011162229240.4961-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Alan Cox wrote:

> > 	The Unofficial Linus HOWTO
> 
> 	'Care And Operation Of Your Linus Torvalds'
> 
> 
> > 	mv linux linux-vanilla
> > 	diff -urN linux-vanilla $MYSRC > /tmp/patch
> 
> Include Tigrans recommended exclude list and info

Alan Cox is very concise. I shall interpret :)

He refers to the dontdiff file I currently maintain on:

http://www.moses.uklinux.net/patches/dontdiff

and the command line to make the patch would become:

diff -urN -X dontdiif linux $MYSRC > /tmp/mysrc.patch

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
