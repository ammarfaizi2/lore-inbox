Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129620AbRBSOtF>; Mon, 19 Feb 2001 09:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130422AbRBSOsz>; Mon, 19 Feb 2001 09:48:55 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:56076 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S129620AbRBSOss>; Mon, 19 Feb 2001 09:48:48 -0500
Date: Mon, 19 Feb 2001 14:48:43 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sendfile from char device?
In-Reply-To: <Pine.LNX.3.96.1010219084411.17842A-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10102191446130.11954-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Jeff Garzik wrote:

> > But, unfortunately, sendfile (in 2.2 and 2.4) appears not
> > to support sendfile(2)ing a device:
>
> Correct... sendfile(2) is only for sources/destinations that can be
> ripped through the page cache.

I knew that, but was surprised that /dev/zero didn't have
->readpage().  Any pointers to assist me to implement one?

Matthew.

