Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTJaIBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 03:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTJaIBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 03:01:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:50611 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263077AbTJaIBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 03:01:12 -0500
Date: Fri, 31 Oct 2003 00:03:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: ahuisman@cistron.nl, linux-kernel@vger.kernel.org
Subject: Re: READAHEAD
Message-Id: <20031031000308.75c574da.akpm@osdl.org>
In-Reply-To: <3FA212BD.3070408@vgertech.com>
References: <bnrdqi$uho$1@news.cistron.nl>
	<20031030134407.0c97c86e.akpm@osdl.org>
	<3FA212BD.3070408@vgertech.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Silva <nuno.silva@vgertech.com> wrote:
>
> >> Before, i never had to set readahead so high
> >> Please could you tell me, what is going on here ?
> > 
> > 
> > Lots of people have been reporting this.  It's rather weird.
> > 
> 
> I know nothing about this but, FWIW, I think that what changed where the 
> units. With 2.4 you specify sectors, with 2.6 you specify bytes.
> 
> So, having -a8, in 2.4, is the same as having -a$((8*512)) [it's 4096 
> :)], in 2.6.
> 

No, everything seems OK.  Both `hdparm -a' and `blockdev --setra' are
operating in units of 512 bytes.

