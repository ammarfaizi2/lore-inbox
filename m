Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUBYTRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUBYTRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:17:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:49343 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261540AbUBYTQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:16:12 -0500
Date: Wed, 25 Feb 2004 11:16:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reaim - 2.6.3-mm1 IO performance down.
Message-Id: <20040225111633.46ddacc7.akpm@osdl.org>
In-Reply-To: <200402251740.i1PHetn27447@mail.osdl.org>
References: <20040224170337.798f5766.akpm@osdl.org>
	<200402251740.i1PHetn27447@mail.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White <cliffw@osdl.org> wrote:
>
>  > Thanks.  You could try reverting adaptive-lazy-readahead.patch.  If it is
>  > not that I'd be suspecting CPU scheduler changes.  Do you have uniprocessor
>  > test results?
> 
>  I have them for 2.6.3-mm3, am re-running 2.6.3-mm1 right now.
>  Gross results are within 1%, but looking at the detail, i do see badness,

OK, I'll do the bsearch.  Again.  Could you please tell me what would be an
appropriate reaim command line with which to reproduce this?

