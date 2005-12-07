Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVLGKpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVLGKpQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVLGKpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:45:16 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:64982 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750834AbVLGKpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:45:14 -0500
Date: Wed, 7 Dec 2005 19:11:17 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 12/16] mm: fold sc.may_writepage and sc.may_swap into sc.flags
Message-ID: <20051207111117.GA8001@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	Christoph Lameter <christoph@lameter.com>,
	Rik van Riel <riel@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
	Andrea Arcangeli <andrea@suse.de>
References: <20051207104755.177435000@localhost.localdomain> <20051207105154.142779000@localhost.localdomain> <4396BB27.50104@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4396BB27.50104@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 09:36:23PM +1100, Nick Piggin wrote:
> Wu Fengguang wrote:
> >Fold bool values into flags to make struct scan_control more compact.
> >
> 
> Probably not a bad idea (although you haven't done anything for 64-bit
> archs, yet)... do we wait until one more flag wants to be added?

I did this to hold some more debug flags :)
I'll make it a standalone patch, too.

Wu
