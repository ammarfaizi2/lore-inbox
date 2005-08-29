Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVH2Rpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVH2Rpv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVH2Rpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:45:51 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:10274 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751177AbVH2Rpu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:45:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TgsjTam/6XBS4LKGbHC3Snv4B84Mw8KkKcw4/84jeK69mIPNMmIoepWgwjOUC5DvPO6qi7igdqF7fuzu/R+nGvITcd1omG0tQL2Vkiuo280PGo3xgNwcKxKs2QNHjaVpqC6iO5zwpW/NwCRTzKM8HqM6h7AdWiWoUml6vQyJeAw=
Message-ID: <9a87484905082910455100911d@mail.gmail.com>
Date: Mon, 29 Aug 2005 19:45:49 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: [PATCH] convert verify_area to access_ok in xtensa/kernel/signal.c
Cc: Chris Zankel <chris@zankel.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508291337570.4864@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508291931.00764.jesper.juhl@gmail.com>
	 <Pine.LNX.4.61.0508291337570.4864@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
> 
> On Mon, 29 Aug 2005, Jesper Juhl wrote:
> 
> >
> > verify_area() is deprecated and has been for quite a while.
[snip]
> >
> > This patch converts all uses of verify_area() in xtensa/kernel/signal.c to
> > use access_ok() instead.
> >
> > Please apply.
> >
> 
> Isn't access_ok() also gone, handled by the put/get/copy/to/from/user
> stuff?
> 
No. access_ok() is still used extensively.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
