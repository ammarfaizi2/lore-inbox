Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269093AbUHXWwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269093AbUHXWwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 18:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269094AbUHXWwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 18:52:19 -0400
Received: from hera.kernel.org ([63.209.29.2]:56522 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S269093AbUHXWwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 18:52:13 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Linux 2.6.9-rc1
Date: Tue, 24 Aug 2004 22:52:02 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cgggqi$c78$1@terminus.zytor.com>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org> <20040824184245.GE5414@waste.org> <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1093387922 12521 127.0.0.1 (24 Aug 2004 22:52:02 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 24 Aug 2004 22:52:02 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
By author:    Linus Torvalds <torvalds@osdl.org>
In newsgroup: linux.dev.kernel
> 
> Hmm.. I have no strong preferences. There _is_ obviously a well-defined 
> ordering from x.y.z.1 -> x.y.z.2 (unlike the -rcX releases that don't have 
> any ordering wrt the bugfixes), so either interdiffs or whole new full 
> diffs are totally "logical". We just have to chose one way or the other, 
> and I don't actually much care.
> 
> Any reason for your preference? 
> 

I concur with this preference, and for this reason:

Right now I'm treating x.y.z.w as a strange form of -pre, -rc, or
-test kernels.

Dealing with the various forms of the kernel naming scheme would
become even more complex if point releases were handled differently.

	-hpa

