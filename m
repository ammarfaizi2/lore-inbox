Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVCWBKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVCWBKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 20:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVCWBKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 20:10:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:54694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262586AbVCWBKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 20:10:35 -0500
Date: Tue, 22 Mar 2005 17:10:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: tony.luck@intel.com, davem@davemloft.net, nickpiggin@yahoo.com.au,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322171013.5c52dd18.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0503230052500.10858@goblin.wat.veritas.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03211851@scsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.61.0503230052500.10858@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Tue, 22 Mar 2005, Luck, Tony wrote:
>  > 
>  > But I'm still confused by all the math on addr/end at each
>  > level.
> 
>  You think the rest of us are not ;-?

umm, given the difficulty which you guys are having with this, I get a bit
worried about clarity, simplicity and maintainability of the end result.
