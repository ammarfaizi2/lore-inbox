Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSEXJ5E>; Fri, 24 May 2002 05:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317118AbSEXJ5E>; Fri, 24 May 2002 05:57:04 -0400
Received: from imladris.infradead.org ([194.205.184.45]:17670 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317117AbSEXJ5C>; Fri, 24 May 2002 05:57:02 -0400
Date: Fri, 24 May 2002 10:56:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andries.Brouwer@cwi.nl, Alan Cox <alan@lxorguk.ukuu.org.uk>, hpa@zytor.com,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: IO stats in /proc/partitions
Message-ID: <20020524105632.A7658@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, Andries.Brouwer@cwi.nl,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, hpa@zytor.com,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020516085022.B14643@infradead.org> <Pine.LNX.4.21.0205231723450.3295-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 05:27:13PM -0300, Marcelo Tosatti wrote:
> > I rather send a complete backout patch for mainline instead.  This format
> > has been used by the vendor (Red Hat, SuSE, etc..) kernels since 2.2 ages
> > and is used (if present) by the stock performance tools for linux
> > (i.e. syststat package, iostats
> 
> Look, I just do not want to break some apps which read /proc/partitions.
> Thats it.

Umm, thos apps would have broken on any stock Red Hat/SuSE/Mandrake
installation of the last years!

> Look, changing the userlevel apps to at least know about the new format is
> not hard. And you can do that over time.

Well, the stock sysstat util works with this format now with the vendor
kernels, recent -ac and 2.4.19-pre.  If you don't want this I can send
a backout patch - again only people using vendor kernel or maybe -ac
will have that feature.  No big point.

