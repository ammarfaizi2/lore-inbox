Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbVLGMjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVLGMjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVLGMjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:39:45 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:38853 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750995AbVLGMjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:39:45 -0500
Date: Wed, 7 Dec 2005 21:01:22 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 12/16] mm: fold sc.may_writepage and sc.may_swap into sc.flags
Message-ID: <20051207130122.GB5355@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	Christoph Lameter <christoph@lameter.com>,
	Rik van Riel <riel@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
	Andrea Arcangeli <andrea@suse.de>
References: <20051207104755.177435000@localhost.localdomain> <20051207105154.142779000@localhost.localdomain> <4396BB27.50104@yahoo.com.au> <20051207111117.GA8001@mail.ustc.edu.cn> <4396C3AC.9000802@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4396C3AC.9000802@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 10:12:44PM +1100, Nick Piggin wrote:
> >I did this to hold some more debug flags :)
> 
> Yes, but if they make sense for the current kernel too, it reduces
> the peripheral noise out of your patchset... which helps everyone :)

Thanks. I have not been quite aware of this, sorry.

Wu
