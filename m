Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbULMVV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbULMVV0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbULMVV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:21:26 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:23002 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261153AbULMVVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:21:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=J4+s+ZV1xmbYc5RtPn1dixHgJUOI8l9QiKg+3WP0Z/8x9Y/nXO51mEzQJHY1d8BoAhF1z/43Y/LYdvRLl684AmrzpHgma3yyFFcbHbtqBreY6E7mowmtIZK1JwiTLelwpC5jNO4a2Az7HsrFWW6zBVZXf5PbuQyOxdlHCvoblmU=
Message-ID: <58cb370e0412131321694a6516@mail.gmail.com>
Date: Mon, 13 Dec 2004 22:21:13 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Junio C Hamano <junkio@cox.net>
Subject: Re: CD-ROM ide-dma blacklist amnesty drive
Cc: linux-kernel@vger.kernel.org,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>
In-Reply-To: <7v7jns2tu3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <cp78ct$d65$1@sea.gmane.org>
	 <7v7jns2tu3.fsf@assigned-by-dhcp.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2004 16:33:56 -0800, Junio C Hamano <junkio@cox.net> wrote:
> Alexander E. Patrakov wrote:
> 
> >The "SAMSUNG CD-ROM SC-148F" drive is listed in drive_blacklist in
> >ide-dma.c. However, this drive worked well with DMA enabled with earlier
> >kernel versions (<=2.6.8.1) where the "via82cxxx" driver did not look at
> >this blacklist. So the question: what was the reason for blacklisting this
> >(apparently working) drive? Is it still valid?
> 
> This was discussed about two months ago without a firm
> resolution as far as I can tell, in this thread:
> 
>     http://thread.gmane.org/gmane.linux.kernel/241862
> 
> Especially from Jens and Alan:
> 
>     http://article.gmane.org/gmane.linux.kernel/242226
>     http://article.gmane.org/gmane.linux.kernel/242228
> 
> I've been meaning to start a "CD-ROM ide-dma blacklist amnesty
> drive" ;-) The intent is to gather comments from owners of
> blacklisted drives to see if those models still deserve to be on
> the blacklist.
> 
> As for myself, I would vote for removing "PLEXTOR CD-R
> PX-W8432T" (at least firmware "1.09") from the list.  This model
> seems to work fine with DMA.  As Alexander does, I have been
> running it on VIA motherboard which only recently started
> looking at the ide-dma blacklist without trouble; that is,
> before via82cxxx started caring.

Plextor drive removed from the blacklist, thanks
