Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTD3PvC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTD3PvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:51:02 -0400
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:54724 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S262349AbTD3PvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:51:01 -0400
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dphillips@sistina.com, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
References: <Pine.LNX.4.44.0304300824190.7157-100000@home.transmeta.com>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 30 Apr 2003 18:03:14 +0200
In-Reply-To: <Pine.LNX.4.44.0304300824190.7157-100000@home.transmeta.com>
Message-ID: <87el3kt1kt.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-AntiVirus: checked by AntiVir Milter 1.0.0.8; AVE 6.19.0.3; VDF 6.19.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> There is _never_ any excuse to use a lookup table for something that
> can be calculated with a few simple instructions. That's just
> stupid.

Well, the "few simple instructions" are 28 instructions on Alpha for
example, including 6 data-dependent branches. So I don't think it's
*that* stupid.

But I agree that benchmarking this stand-alone isn't particularly
useful.

-- 
	Falk
