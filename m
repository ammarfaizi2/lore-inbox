Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSHQOxr>; Sat, 17 Aug 2002 10:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSHQOxr>; Sat, 17 Aug 2002 10:53:47 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:22543 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316322AbSHQOxr>; Sat, 17 Aug 2002 10:53:47 -0400
Date: Sat, 17 Aug 2002 15:57:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: Re: Linux 2.4.20-pre3
Message-ID: <20020817155733.A13576@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	lkml <linux-kernel@vger.kernel.org>,
	Rusty Trivial Russell <trivial@rustcorp.com.au>
References: <Pine.LNX.4.44.0208162231060.8044-100000@freak.distro.conectiva> <Pine.GSO.4.21.0208171603260.12155-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0208171603260.12155-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Sat, Aug 17, 2002 at 04:12:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 04:12:03PM +0200, Geert Uytterhoeven wrote:
> On Fri, 16 Aug 2002, Marcelo Tosatti wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk>:
> >   o files_init - set file limit based on ram
> 
> Add missing prototype (cfr. 2.5.x).
> BTW, the one is 2.5.x is wrong because it lacks the __init

The prototype doesn't need the __init, and consensus is to not add it.

