Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbUCSR3w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 12:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbUCSR3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 12:29:52 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:22153 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S263064AbUCSR3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 12:29:47 -0500
Date: Fri, 19 Mar 2004 17:27:43 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: David Schwartz <davids@webmaster.com>
cc: Justin Piszcz <jpiszcz@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux Kernel Microcode Question
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMENKLCAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.44.0403191721110.3892-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, David Schwartz wrote:
> 	It is at least theoeretically possible that a microcode update might cause
> an operation that's normally done very quickly (in dedicated hardware) to be
> done by a slower path (microcode operations) to fix a bug in the dedicated
> hardware

Did you dream that up or did you read it somewhere? If the latter, where?

All operations are done by "dedicated hardware" and microcode DOES modify
that hardware, or rather the way instructions are "digested". So, applying
microcode doesn't make anything slower per se, it's just replacing one
code sequence with another code sequence. If a new code happens to be
slower than the old one then of course the result will be slower, but the
reverse is also true. When you fix a bug in a particular software why
should a bugfix be apriori slower than the original code? Think about it.

So please do not spread misinformation that applying microcode makes 
something slower. If anything, it should make things faster, as long as 
the guys at Intel are writing the correct (micro)code.

Kind regards
Tigran


