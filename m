Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTEAOCW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbTEAOCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:02:22 -0400
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:16066 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S261265AbTEAOCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:02:22 -0400
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: Willy TARREAU <willy@w.ods.org>
Cc: hugang <hugang@soulinfo.com>, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
References: <200304300446.24330.dphillips@sistina.com>
	<20030430135512.6519eb53.akpm@digeo.com>
	<20030501130318.459a4776.hugang@soulinfo.com>
	<20030430221129.11595e2e.akpm@digeo.com>
	<20030501133307.158c7e10.hugang@soulinfo.com>
	<20030501150557.6dc913f7.hugang@soulinfo.com>
	<20030501135204.GC308@pcw.home.local>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 01 May 2003 16:14:17 +0200
In-Reply-To: <20030501135204.GC308@pcw.home.local>
Message-ID: <87fzny3gau.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-AntiVirus: checked by AntiVir Milter 1.0.0.8; AVE 6.19.0.3; VDF 6.19.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy TARREAU <willy@w.ods.org> writes:

> On Thu, May 01, 2003 at 03:05:57PM +0800, hugang wrote:
> Ok, I recoded the tree myself with if/else, and it's now faster than
> all others, whatever the compiler.

Have you tried with not simply increasing, but random numbers? I guess
this could make quite a difference here because of branch prediction.

-- 
	Falk
