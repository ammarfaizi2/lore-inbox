Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUBYQT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbUBYQSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:18:44 -0500
Received: from hera.kernel.org ([63.209.29.2]:45503 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261406AbUBYQR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:17:27 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Intel vs AMD x86-64
Date: Wed, 25 Feb 2004 16:17:21 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1ihqh$e0r$1@terminus.zytor.com>
References: <7F740D512C7C1046AB53446D37200173EA2718@scsmsx402.sc.intel.com> <403CCBE0.7050100@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077725841 14364 63.209.29.3 (25 Feb 2004 16:17:21 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 25 Feb 2004 16:17:21 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <403CCBE0.7050100@techsource.com>
By author:    Timothy Miller <miller@techsource.com>
In newsgroup: linux.dev.kernel
>
> 
> Nakajima, Jun wrote:
> > No, it's not a problem. Branches with 16-bit operand size are not useful
> > for compilers.
> 
>  From AMD's documentation, I got the impression that 66H caused near 
> branches to be 32 bits in long mode (default is 64).
> 
> So, Intel makes it 16 bits, and AMD makes it 32 bits?
> 
> Either way, I don't see much use for either one.
> 

Both claims are pretty bogus.  Shorter branches are quite nice for
intraprocedural jumps; it reduces the cache footprint.

	-hpa

