Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVJQQcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVJQQcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVJQQcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:32:33 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28567 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750742AbVJQQcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:32:32 -0400
Subject: Re: VFS: file-max limit 50044 reached
From: Lee Revell <rlrevell@joe-job.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <4353CADB.8050709@cosmosbay.com>
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org>
	 <JTFDVq8K.1129537967.5390760.khali@localhost>
	 <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com>
	 <20051017103244.GB6257@in.ibm.com>
	 <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org>
	 <4353CADB.8050709@cosmosbay.com>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 12:31:56 -0400
Message-Id: <1129566717.1321.39.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 18:01 +0200, Eric Dumazet wrote:
> A 'realtime refinement' would be to use a different maxbatch limit depending 
> on the caller's priority : Let a softirq thread have a lower batch count than 
> a regular user thread.

Or just make the whole thing preemptible like in the -rt tree and forget
about it.

Lee

