Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318844AbSHLWLb>; Mon, 12 Aug 2002 18:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318845AbSHLWLb>; Mon, 12 Aug 2002 18:11:31 -0400
Received: from c-180-196-67.ka.dial.de.ignite.net ([62.180.196.67]:12418 "EHLO
	c-180-196-67.ka.dial.de.ignite.net") by vger.kernel.org with ESMTP
	id <S318844AbSHLWLa>; Mon, 12 Aug 2002 18:11:30 -0400
Date: Mon, 12 Aug 2002 09:45:48 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: gcc@gcc.gnu.org, Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: GCC still keeps empty loops?  (was: [patch 4/21] fix ARCH_HAS_PREFETCH)
Message-ID: <20020812094548.A22879@bacchus.dhis.org>
References: <3D56B13A.D3F741D1@zip.com.au> <Pine.LNX.4.44.0208111203520.9930-100000@home.transmeta.com> <20020811210718.B3206@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020811210718.B3206@kushida.apsleyroad.org>; from lk@tantalophile.demon.co.uk on Sun, Aug 11, 2002 at 09:07:18PM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 09:07:18PM +0100, Jamie Lokier wrote:

> Unbelievably, 3.1 doesn't remove empty loops either.
> I think there's a case for a compiler flag, `-fremove-empty-loops'.

Indeed ...  It's sad having to scatter ifdefs over the code just because
gcc lacks this optimization ...

  Ralf
