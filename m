Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUHXUII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUHXUII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267795AbUHXUII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:08:08 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:7889 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S267565AbUHXUIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:08:01 -0400
Date: Tue, 24 Aug 2004 22:07:50 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Matt Mackall <mpm@selenic.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
In-Reply-To: <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.53.0408242202450.7152@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
 <20040824184245.GE5414@waste.org> <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Linus Torvalds wrote:

> Hmm.. I have no strong preferences. There _is_ obviously a well-defined 
> ordering from x.y.z.1 -> x.y.z.2 (unlike the -rcX releases that don't have 
> any ordering wrt the bugfixes), so either interdiffs or whole new full 
> diffs are totally "logical". We just have to chose one way or the other, 
> and I don't actually much care.
> 
> Any reason for your preference? 

I'd also vote for the x.y.z.2 to be based on x.y.z, because it's 
consistent with common practice. Currently all patches that I know of
that have an EXTRAVERSION are based on the corresponding kernels with
empty EXTRAVERSION. Be it -pre, -rc, -mm, -ac or whatever.

Tim
