Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbULBBVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbULBBVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 20:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbULBBVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 20:21:30 -0500
Received: from hera.kernel.org ([63.209.29.2]:64215 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261536AbULBBV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 20:21:28 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Thu, 2 Dec 2004 01:21:20 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <colqmg$jcd$1@terminus.zytor.com>
References: <19865.1101395592@redhat.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <1101721336.21273.6138.camel@baythorne.infradead.org> <20041201114622.GB4876@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1101950481 19854 127.0.0.1 (2 Dec 2004 01:21:20 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 2 Dec 2004 01:21:20 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20041201114622.GB4876@linux-mips.org>
By author:    Ralf Baechle <ralf@linux-mips.org>
In newsgroup: linux.dev.kernel
> 
> The concept of copying kernel headers into applications is even worse
> when arch portability is affected.  I stopped counting how often I had
> to fix that kind of crap - and the state of kernel headers and userspace
> kernel header packages is really provoking that kind of mess.
> 

Indeed.  The major reason why we need the kernel to export its own ABI
information is because there are at my last counting 18 architectures
running stock Linux, and each one of them has *at least* one ABI, and
they're all different.

	-hpa
