Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbVJCTDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbVJCTDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbVJCTDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:03:08 -0400
Received: from free.hands.com ([83.142.228.128]:19934 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932626AbVJCTDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:03:07 -0400
Date: Mon, 3 Oct 2005 20:02:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Vadim Lobanov <vlobanov@speakeasy.net>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051003190255.GC8548@lkcl.net>
References: <200510030212.j932CcKT025910@laptop11.inf.utfsm.cl> <200510031632.j93GWZbY012554@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510031632.j93GWZbY012554@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 12:32:35PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 02 Oct 2005 22:12:38 EDT, Horst von Brand said:
> 
> > >                                                                     some
> > >  operating system primitives, such as message passing (based on a
> > >  derivative by thompson of the "alice" project from plessey, imperial and
> > >  manchester university in the mid-80s), hardware cache line lookups
> > >  (which means instead of linked list searching, the hardware does it for
> > >  you in a single cycle), stuff like that.
> > 
> > Single CPU cycle for searching data in memory? Impossible.
> 
> Well... if it was content-addressable RAM similar to what's already used for
> the hardware TLB's and the like - just that it's one thing to make a 32 or 256
> location content-addressable RAM, and totally another to have multiple megabytes
> of the stuff. :)

 aspex microelectronics 4096 2-bit massively parallel SIMD
 processor (does 1 terabit-ops / sec @ 250mhz which sounds a
 lot until you try to do FPU emulation on it).

 each 2-bit processor has 256 bits of content-addressable memory,
 which can be 8-bit, 16-bit or 32-bit addressed (to make 4096 parallel
 memory searches - in a single cycle).

 absolutely friggin blindingly fast for certain issues (video
 processing, certain kinds of audio processing - e.g. FFTs,
 XML and HTTP parsing), and pissed all over for others such
 as doing floating point arithmetic.

 but anyway: that's a side issue.  thanks for reminding me about CAM,
 valdis.

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
