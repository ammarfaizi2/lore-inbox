Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264124AbUECWj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUECWj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 18:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264130AbUECWj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 18:39:27 -0400
Received: from main.gmane.org ([80.91.224.249]:16317 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264124AbUECWjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 18:39:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.6.6-rc3-mm1
Date: Mon, 3 May 2004 22:39:20 +0000 (UTC)
Message-ID: <slrnc9digo.cgh.psavo@varg.dyndns.org>
References: <20040430014658.112a6181.akpm@osdl.org> <slrnc98gnc.cgh.psavo@varg.dyndns.org> <4094CCF9.6070109@yahoo.com.au>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Piggin <nickpiggin@yahoo.com.au>:
> Pasi Savolainen wrote:
>> * Andrew Morton <akpm@osdl.org>:
>> 
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc3/2.6.6-rc3-mm1/
>> 
>> 
>> I'm having severe interactivity problems with 2.6 tree on a dual Athlon system.
>> I mostly get 'X screen freezes/mouse pointer immovable for a several
>> seconds' and rather often audio skips.
>> 
>
> Make sure X is running at the normal priority (ie 0).
> Does that improve things?

It already is at nice 0.

The slab shrinking fix Andrew provided reduced all the swapping to
minimum. So far 2.6.6-rc3+shrink_slab-handle-GFP_NOFS-fix has been the
most 'responsive' 2.6 (I've been following rather closely sice 2.5.75).

I can still trigger staggering and short (1/2sec) pauses when there's
memory pressure and I quit some swapped-out application. It's been this
way for a long time.

Thanks.
-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

