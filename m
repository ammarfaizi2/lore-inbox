Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbTGKUma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265421AbTGKUm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:42:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:42640 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265326AbTGKUly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:41:54 -0400
Date: Fri, 11 Jul 2003 17:54:12 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre5
In-Reply-To: <shsu19siyru.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.55L.0307111752060.5537@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva>
 <shsu19siyru.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jul 2003, Trond Myklebust wrote:

>
> Is there still any chance for the NFS O_DIRECT support to make it?

Yes.

I guess the best way of doing so would be adding ->direct_io2 and
KERNEL24_HAS_ODIRECT_2 define.

Correct?

