Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267927AbUHESlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267927AbUHESlh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267920AbUHESkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:40:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:11245 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267895AbUHESiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:38:17 -0400
Date: Thu, 5 Aug 2004 11:36:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ricklind@us.ibm.com, mbligh@aracnet.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: 2.6.8-rc2-mm2, schedstat-2.6.8-rc2-mm2-A4.patch
Message-Id: <20040805113627.13e0feab.akpm@osdl.org>
In-Reply-To: <20040805143249.GA23967@elte.hu>
References: <20040804212658.GA26023@elte.hu>
	<200408042210.i74MAF203428@owlet.beaverton.ibm.com>
	<20040805143249.GA23967@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> * Rick Lindsley <ricklind@us.ibm.com> wrote:
> 
>  > The version below is for 2.6.8-rc2-mm2 without the staircase code and
>  > has been compiled cleanly but not yet run.
> 
>  it looks good in principle, but this code needs a couple of cleanups
>  before it can go into mainline. I've attached 3 patches, your original,
>  the fixed up version and a delta that does the fixups relative to your
>  patch.

OK, thanks.  I dropped the three schedstats patches, added schedstat-v10. 
My current rollup (which is pretty much rc3-mm1 with only that change) is
at http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2.  Additional
scheduler work should be against that tree, please.

