Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268220AbUHXTZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268220AbUHXTZw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268219AbUHXTZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:25:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:55447 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268229AbUHXTXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:23:48 -0400
Date: Tue, 24 Aug 2004 12:23:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
In-Reply-To: <20040824184245.GE5414@waste.org>
Message-ID: <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
 <20040824184245.GE5414@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Aug 2004, Matt Mackall wrote:
> 
> Phew, I was worried about that. Can I get a ruling on how you intend
> to handle a x.y.z.1 to x.y.z.2 transition? I've got a tool that I'm
> looking to unbreak. My preference would be for all x.y.z.n patches to
> be relative to x.y.z.

Hmm.. I have no strong preferences. There _is_ obviously a well-defined 
ordering from x.y.z.1 -> x.y.z.2 (unlike the -rcX releases that don't have 
any ordering wrt the bugfixes), so either interdiffs or whole new full 
diffs are totally "logical". We just have to chose one way or the other, 
and I don't actually much care.

Any reason for your preference? 

		Linus
