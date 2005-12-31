Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVLaL3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVLaL3c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbVLaL3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:29:32 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.13]:29213 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751078AbVLaL3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:29:31 -0500
Subject: Re: [PATCH 6/9] clockpro-clockpro.patch
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>
In-Reply-To: <20051231002417.GA4913@dmt.cnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
	 <20051230224312.765.58575.sendpatchset@twins.localnet>
	 <20051231002417.GA4913@dmt.cnet>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 12:29:06 +0100
Message-Id: <1136028546.17853.69.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot one in the previous mail.

On Fri, 2005-12-30 at 22:24 -0200, Marcelo Tosatti wrote:
> Please make it easier for others to understand why the hands 
> swap, and when, and why.

Its not the hands that swap, its the lists. The hands will lap each
other, like the minute hand will lap the hour hand every ~65 minutes.

Let me try some ascii art.

   ====
  ^---<>---v
       ====

'='	a page
'^---<' hand cold
'>---v' hand hot

now let hand cold move 4 pages:

   
  ^---<>---v
   ========

ie. hand hot and hand cold have the same position.
now if we want to move hand cold one more position this happens:

   =======
  ^---<>---v
          =

see the swap?
-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

