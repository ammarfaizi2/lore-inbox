Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUFAUxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUFAUxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUFAUxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:53:21 -0400
Received: from hera.kernel.org ([63.209.29.2]:59096 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265226AbUFAUxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:53:12 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: How to use floating point in a module?
Date: Tue, 1 Jun 2004 20:52:37 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c9iqal$35d$1@terminus.zytor.com>
References: <200406010038.i510cxk23507@mailout.despammed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1086123157 3256 127.0.0.1 (1 Jun 2004 20:52:37 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 1 Jun 2004 20:52:37 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200406010038.i510cxk23507@mailout.despammed.com>
By author:    ndiamond@despammed.com
In newsgroup: linux.dev.kernel
> 
> (The CPU is an i686.  I'll have to look up its opcodes and see if its
> hardware will come close enough for everything the driver needs.  If it
> doesn't, I'll buy one of the books that some others kindly recommended
> and do polynomial approximations.)  (By the way the driver is being
> ported from VxWorks, where it seems that the kernel can do floating
> point including trig, logarithms, etc.)
> 

On x86 (more specifically, on x87) if you can do it at all then you
can do them all.  All that really means is that the fp library is in
microcode on x87.

	-hpa

