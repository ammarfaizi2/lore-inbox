Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269033AbUHMItU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269033AbUHMItU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 04:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269034AbUHMItU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 04:49:20 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:3156 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S269033AbUHMItS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 04:49:18 -0400
Subject: Re: linux-2.6.8-rc4-bk1 - nfsd oops when starting the first client
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Alexander Stohr <Alexander.Stohr@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <21288.1092383986@www20.gmx.net>
References: <21288.1092383986@www20.gmx.net>
Content-Type: text/plain
Date: Fri, 13 Aug 2004 10:49:16 +0200
Message-Id: <1092386956.6815.8.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 09:59 +0200, Alexander Stohr wrote:
> Hello,
> 
> i am getting reproducible kernel oopses in a test environment
> when booting the first diskless client (2.0.40-rc6)
> for a dual (=SMP) AMD Athlon(tm) MP 1900+ that 
> is running a recent linux 2.6 bitkeeper kernel.
> the oops exactly happens when the (trough bootp provided)
> kernel on the client has fully started and wants 
> to access one of the first files on the server
> by means of an nfs access.
> 
> see the system messages in the attachment.
> 
> the problem was never seen in kernel 2.6.7 
> for that or any other server.
> 
> is this problem known to the audience?
> is there a patch to test for this problem?
> 
> -Alex. (i am not subscribed to this list, please CC me)
> 
> PS: due to sheduled two weeks absence i will not be able
> to check my e-mail regularily.

This might solve it:
	http://lkml.org/lkml/2004/8/11/264

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

