Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265301AbUGGSrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUGGSrt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbUGGSrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:47:48 -0400
Received: from [213.146.154.40] ([213.146.154.40]:13967 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265301AbUGGSrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:47:39 -0400
Date: Wed, 7 Jul 2004 19:47:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: tom st denis <tomstdenis@yahoo.com>
Cc: Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040707184737.GA25357@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	tom st denis <tomstdenis@yahoo.com>,
	Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org
References: <20040707163048.GA30840@iram.es> <20040707184150.76132.qmail@web41109.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707184150.76132.qmail@web41109.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 11:41:50AM -0700, tom st denis wrote:
> Um, actually "char" like "int" and "long" in C99 is signed.  So while
> you can write 
> 
> signed int x = -3;
> 
> You don't have to.  in fact if you "have" to then your compiler is
> broken.  Now I know that GCC offers "unsigned chars" but that's an
> EXTENSION not part of the actual standard.  

------------------------------ snip -----------------------------
 [#15]  The  three types char, signed char, and unsigned char
        are   collectively   called   the   character   types.   The
        implementation  shall  define  char  to have the same range,
	representation,  and  behavior  as  either  signed  char or
	unsigned char.35)
------------------------------ snip -----------------------------
 
> As for writing portable code, um, jacka#!, BitKeeper, you know, that
> thingy that hosts the Linux kernel?  Yeah it uses LibTomCrypt.  Why not
> goto http://libtomcrypt.org and find out who the author is.  Oh yeah,
> that would be me.  Why not email Wayne Scott [who has code in
> LibTomCrypt btw...] and ask him about it?
> 
> Who elses uses LibTomCrypt?  Oh yeah, Sony, Gracenote, IBM [um Joy
> Latten can chip in about that], Intel, various schools including
> Harvard, Stanford, MIT, BYU, ...

Tons of people use windows aswell.  You just showed that you don't know
C well enough, so maybe someone should better do an audit for your code ;-)
