Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268350AbUHXVZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268350AbUHXVZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268347AbUHXVZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:25:13 -0400
Received: from jade.spiritone.com ([216.99.193.136]:38365 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268332AbUHXVW5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:22:57 -0400
Date: Tue, 24 Aug 2004 14:22:34 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
Message-ID: <64420000.1093382553@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org><20040824184245.GE5414@waste.org> <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Linus Torvalds <torvalds@osdl.org> wrote (on Tuesday, August 24, 2004 12:23:42 -0700):
> On Tue, 24 Aug 2004, Matt Mackall wrote:
>> 
>> Phew, I was worried about that. Can I get a ruling on how you intend
>> to handle a x.y.z.1 to x.y.z.2 transition? I've got a tool that I'm
>> looking to unbreak. My preference would be for all x.y.z.n patches to
>> be relative to x.y.z.
> 
> Hmm.. I have no strong preferences. There _is_ obviously a well-defined 
> ordering from x.y.z.1 -> x.y.z.2 (unlike the -rcX releases that don't have 
> any ordering wrt the bugfixes), so either interdiffs or whole new full 
> diffs are totally "logical". We just have to chose one way or the other, 
> and I don't actually much care.
> 
> Any reason for your preference? 

>From an automated tool point of view, it's easier to build a kernel
with just tarball + 1 patch (I have much the same issues as Matt to deal
with) ... also it works the same way as the current -rc releases, etc, 
so it's consistent.

M.

