Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262571AbSI0SVk>; Fri, 27 Sep 2002 14:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262578AbSI0SVk>; Fri, 27 Sep 2002 14:21:40 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:44534 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262571AbSI0SVi>; Fri, 27 Sep 2002 14:21:38 -0400
Subject: Re: [patch] 'virtual => physical page mapping cache',
	vcache-2.5.38-B8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209271952540.17034-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0209271952540.17034-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Sep 2002 19:01:15 +0100
Message-Id: <1033149675.16758.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-27 at 18:53, Ingo Molnar wrote:
> 
> On Fri, 27 Sep 2002, Chris Wedgwood wrote:
> 
> > O_DIRECT is allow to break if someone does something silly :)  [...]
> 
> to DMA into a page that does not belong to the process anymore? I doubt
> that.

Try doing a truncate on a file as an O_DIRECT write is occuring.
Scribbling into pages you dont own is the least of your problems.


