Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVLaOqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVLaOqA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 09:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVLaOqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 09:46:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:199 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932294AbVLaOp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 09:45:59 -0500
Date: Sat, 31 Dec 2005 09:44:07 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>
Subject: Re: [PATCH 01/14] page-replace-single-batch-insert.patch
In-Reply-To: <20051231070320.GA9997@dmt.cnet>
Message-ID: <Pine.LNX.4.63.0512310943450.27198@cuia.boston.redhat.com>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
 <20051230224002.765.28812.sendpatchset@twins.localnet> <20051231070320.GA9997@dmt.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005, Marcelo Tosatti wrote:

> Unification of active and inactive per cpu page lists is a requirement 
> for CLOCK-Pro, right?

You can approximate the functionality through use of scan
rates.  Not quite as accurate as a unified clock, though.

-- 
All Rights Reversed
