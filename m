Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266788AbTGKVoA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbTGKVoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:44:00 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25249 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S266788AbTGKVn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:43:59 -0400
Date: Fri, 11 Jul 2003 18:56:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre5
In-Reply-To: <16143.10146.718830.585351@charged.uio.no>
Message-ID: <Pine.LNX.4.55L.0307111853540.5883@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva>
 <shsu19siyru.fsf@charged.uio.no> <Pine.LNX.4.55L.0307111752060.5537@freak.distro.conectiva>
 <16143.10146.718830.585351@charged.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Jul 2003, Trond Myklebust wrote:

> >>>>> " " == Marcelo Tosatti <marcelo@conectiva.com.br> writes:
>
>     >> Is there still any chance for the NFS O_DIRECT support to make
>     >> it?
>
>      > I guess the best way of doing so would be adding ->direct_io2
>      > and KERNEL24_HAS_ODIRECT_2 define.
>
> That is what the last patch I sent you does (also sent to l-k). Should

No, no need to resend. I have it.

I released -pre5 so quickly because of the IO hang fix, which is pretty
important. (Christoph: your vmap patch will go on -pre6 too once I read
it).

Well, Jeff, Christoph, do you have any comments on Trond's new
O_DIRECT patch?

I haven't looked at it closely, yet.




