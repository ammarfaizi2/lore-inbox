Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268637AbUHaWr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268637AbUHaWr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269129AbUHaWok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:44:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:49096 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269245AbUHaWnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:43:39 -0400
Date: Tue, 31 Aug 2004 15:47:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Harry Edmon <harry@atmos.washington.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re[4]: PROBLEM: page allocation or what in 2.6.8.1
Message-Id: <20040831154713.470e25a6.akpm@osdl.org>
In-Reply-To: <200408312221.i7VMLHPu007234@moist.atmos.washington.edu>
References: <20040831120232.18dfa3c0.akpm@osdl.org>
	<200408312221.i7VMLHPu007234@moist.atmos.washington.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harry Edmon <harry@atmos.washington.edu> wrote:
>
> So far, no crash.  But now I have NFS clients that from time to time are unable
> to access this server.  The server has the following messages on it:
> 
> Aug 31 15:16:43 funnel rpc.mountd: getfh failed: Operation not permitted
> 
> I can temporarily fix the problem by typing:
> 
> exportfs -ar
> 
> But eventually it happens again.
> 

Well there were a few other NFS fixes.  Can you test the latest kernel
from ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/ ?
