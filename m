Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVLGKm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVLGKm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVLGKm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:42:28 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:19922 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750828AbVLGKm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:42:27 -0500
Date: Wed, 7 Dec 2005 19:08:40 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 06/16] mm: balance slab aging
Message-ID: <20051207110840.GC7570@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Christoph Lameter <christoph@lameter.com>,
	Rik van Riel <riel@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
	Andrea Arcangeli <andrea@suse.de>
References: <20051207104755.177435000@localhost.localdomain> <20051207105019.800865000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207105019.800865000@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A question about the current one:

For a NUMA system with N nodes, the way kswapd calculates lru_pages - only sum
up local zones - may cause N times more shrinking than a 1-CPU system.

Is this a feature or bug?

Thanks,
Wu
