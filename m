Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263310AbSIPXCx>; Mon, 16 Sep 2002 19:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263311AbSIPXCx>; Mon, 16 Sep 2002 19:02:53 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:29938
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263310AbSIPXCx>; Mon, 16 Sep 2002 19:02:53 -0400
Subject: Re: [BUG] NFS in 2.4.20-pre6+ stalls
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209162254.g8GMsmG00784@vindaloo.ras.ucalgary.ca>
References: <200209162254.g8GMsmG00784@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Sep 2002 00:10:21 +0100
Message-Id: <1032217821.2825.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 23:54, Richard Gooch wrote:
>   Hi, all. Just noticed this with 2.4.20-pre6 (and -pre7): NFS write
> sometimes (usually) stalls for minutes at a time. This problem wasn't
> there on 2.4.19. I've noticed this when writing a files around 1 MiB
> or so (some a bit larger, some a bit smaller). It makes NFS almost
> unusable. I've appended the kernel logs which come, at no extra

I've reported the same to Marcelo. Its there in a slightly different
form in my case - low bandwidth streaming data shows it up very well.

