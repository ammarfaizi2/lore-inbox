Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbTBJUjp>; Mon, 10 Feb 2003 15:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbTBJUjo>; Mon, 10 Feb 2003 15:39:44 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:9112 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265134AbTBJUjo>; Mon, 10 Feb 2003 15:39:44 -0500
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] gcc 2.95 vs 3.21 performance
References: <1044908011.3133.123.camel@cube>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 10 Feb 2003 21:49:19 +0100
In-Reply-To: <1044908011.3133.123.camel@cube>
Message-ID: <87isvrhne8.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sourceforge.net> writes:

> BTW, in case any gcc hacker is paying attention, the documentation
> fails to mention the gcc version required for this or any other
> attribute. Also it would be nice to have an option to ditch the
> (char*) exception; it's junk when you have __may_alias__.

I don't think a switch that makes standard compliant source break in
potentially very subtle ways is a good idea. Just use "restrict".

-- 
	Falk
