Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbTA1Qdr>; Tue, 28 Jan 2003 11:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267408AbTA1Qdl>; Tue, 28 Jan 2003 11:33:41 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:19591 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267405AbTA1Qc3>; Tue, 28 Jan 2003 11:32:29 -0500
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Jason Papadopoulos <jasonp@boo.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page coloring for 2.5.59 kernel, version 1
References: <3.0.6.32.20030127224726.00806c20@boo.net>
	<884740000.1043737132@titus> <20030128071313.GH780@holomorphy.com>
	<1466000000.1043770007@titus>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 28 Jan 2003 17:41:23 +0100
In-Reply-To: <1466000000.1043770007@titus>
Message-ID: <87n0llfcr0.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> > I think this one really needs to be done with the userspace cache
> > thrashing microbenchmarks. 
> 
> If a benefit cannot be show on some sort of semi-realistic workload,
> it's probably not worth it, IMHO.

I tested an earlier version on Alpha. While it didn't yield noticeable
performance benefits, it increased the reproducability of my benchmark
a lot, which is also pretty useful.

-- 
	Falk
