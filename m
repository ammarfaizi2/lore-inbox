Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSHTM0P>; Tue, 20 Aug 2002 08:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSHTM0P>; Tue, 20 Aug 2002 08:26:15 -0400
Received: from shaft16-f39.dialo.tiscali.de ([62.246.16.39]:61643 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S316935AbSHTM0O>; Tue, 20 Aug 2002 08:26:14 -0400
Date: Sun, 18 Aug 2002 11:48:58 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818114858.A13115@linux-mips.org>
References: <Pine.LNX.4.44.0208172104420.21581-100000@twinlark.arctic.org> <E17gKXF-0008Ax-00@sites.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17gKXF-0008Ax-00@sites.inka.de>; from ecki-news2002-08@lina.inka.de on Sun, Aug 18, 2002 at 09:31:41AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 09:31:41AM +0200, Bernd Eckenfels wrote:

> dean gaudet <dean-list-linux-kernel@arctic.org> wrote:
> > many southbridges come with audio these days ... isn't it possible to get
> > randomness off the adc even without anything connected to it?
> 
> they also come with RNGs.

I know of one soundcard RND that is simply implemented as a small
mask programmed ROM full of random numbers.  That's good enough for
audio purposes but doesn't even qualify for /dev/urandom's use ...

  Ralf
