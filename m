Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289556AbSBEO6g>; Tue, 5 Feb 2002 09:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289559AbSBEO61>; Tue, 5 Feb 2002 09:58:27 -0500
Received: from ns1.intercarve.net ([216.254.127.221]:64148 "HELO
	ceramicfrog.intercarve.net") by vger.kernel.org with SMTP
	id <S289556AbSBEO6Q>; Tue, 5 Feb 2002 09:58:16 -0500
Date: Tue, 5 Feb 2002 09:54:56 -0500 (EST)
From: "Drew P. Vogel" <dvogel@intercarve.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: opening a bzImage?
In-Reply-To: <Pine.LNX.4.30.0202051538440.13346-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0202050950030.20253-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The GPL does not require them to give you the .config.

I've never tried this, but could you do something like

bunzip2 -c bzImage > zImage && ar -t zImage

?

--Drew Vogel

On Tue, 5 Feb 2002, Roy Sigurd Karlsbakk wrote:

>hi
>
>I have this bzImage file given to me from a company. They don't want to
>give me the .config, but I need it, so I thought I'd try to
>
> - open the bzImage to a vmlinux
> - list the .o's in the vmlinux
>
>Is this possible?
>
>Btw.. Does GPL require them to give me the .config file?
>
>roy
>
>--
>Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
>
>Computers are like air conditioners.
>They stop working when you open Windows.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



