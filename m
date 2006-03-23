Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbWCWECN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWCWECN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 23:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWCWECM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 23:02:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9376 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965171AbWCWECM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 23:02:12 -0500
Date: Wed, 22 Mar 2006 23:01:38 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, iwamoto@valinux.co.jp,
       christoph@lameter.com, wfg@mail.ustc.edu.cn, npiggin@suse.de,
       torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
In-Reply-To: <20060322145132.0886f742.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0603222300320.6212@cuia.boston.redhat.com>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
 <20060322145132.0886f742.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006, Andrew Morton wrote:

> 2.6.16-rc6 seems to do OK.  I assume the cyclic patterns exploit the lru 
> worst case thing?  Has consideration been given to tweaking the existing 
> code, detect the situation and work avoid the problem?

This can certainly be done.  Rate-based clock-pro isn't that
far away mechanically from the current 2.6 code and can be
introduced in small steps.

I'll just have to make it work again ;)

-- 
All Rights Reversed
