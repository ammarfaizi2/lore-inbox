Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261712AbSJBRby>; Wed, 2 Oct 2002 13:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbSJBRby>; Wed, 2 Oct 2002 13:31:54 -0400
Received: from mail.3ware.com ([205.253.146.92]:31249 "EHLO
	siamese.engr.3ware.com") by vger.kernel.org with ESMTP
	id <S261712AbSJBRbw>; Wed, 2 Oct 2002 13:31:52 -0400
Message-ID: <A1964EDB64C8094DA12D2271C04B812672C726@tabby>
From: Adam Radford <aradford@3WARE.com>
To: "'Ken Savage'" <kens1835@shaw.ca>, "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 3ware Escalade 7500 init problems on 2.4.19
Date: Wed, 2 Oct 2002 10:38:53 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like you're failing partition table read.  The very first IO is
timing
out.  Jiggle your power or drive cables and see if the drives seem to 'spin
up'.

-Adam

-----Original Message-----
From: Ken Savage [mailto:kens1835@shaw.ca]
Sent: Wednesday, October 02, 2002 10:19 AM
To: Bryan O'Sullivan
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3ware Escalade 7500 init problems on 2.4.19


On October 2, 2002 10:01, Bryan O'Sullivan wrote:

> The driver that ships with 2.4.19 isn't the most recent, though I doubt
> there's anything in the up-to-date driver that should make a difference.

'diff'ing the drivers, you can see a tiiiiny difference.  As you said,
nothing
that should make a difference.  In either case, both versions of the driver
remain unhappy with the card, failing to initialize it.

> The error message you report is replicated in several spots within the
> driver, so it's not useful in itself.

What additional information would be of assistance?

Ken
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
