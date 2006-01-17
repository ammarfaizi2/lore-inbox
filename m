Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWAQUtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWAQUtW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWAQUtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:49:22 -0500
Received: from silver.veritas.com ([143.127.12.111]:49931 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964839AbWAQUtV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:49:21 -0500
Date: Tue, 17 Jan 2006 20:49:48 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christoph Lameter <clameter@engr.sgi.com>
cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
In-Reply-To: <Pine.LNX.4.62.0601171207300.28161@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0601172047350.9392@goblin.wat.veritas.com>
References: <20060114155517.GA30543@wotan.suse.de>
 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
 <20060114181949.GA27382@wotan.suse.de> <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601151053420.4500@goblin.wat.veritas.com>
 <Pine.LNX.4.62.0601152251080.17034@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601161143190.7123@goblin.wat.veritas.com>
 <Pine.LNX.4.62.0601170926440.24552@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0601171805430.8030@goblin.wat.veritas.com>
 <Pine.LNX.4.62.0601171207300.28161@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Jan 2006 20:49:17.0679 (UTC) FILETIME=[7BC75FF0:01C61BA7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006, Christoph Lameter wrote:
> 
> Simplify migrate_page_add after feedback from Hugh.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

If you're happy with that one, yes, I certainly am too.

Hugh
