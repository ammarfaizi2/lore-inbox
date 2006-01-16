Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWAPGyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWAPGyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 01:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWAPGyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 01:54:47 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:36297 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932185AbWAPGyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 01:54:46 -0500
Date: Sun, 15 Jan 2006 22:54:31 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Magnus Damm <magnus.damm@gmail.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
In-Reply-To: <43C9DD98.5000506@yahoo.com.au>
Message-ID: <Pine.LNX.4.62.0601152251550.17034@schroedinger.engr.sgi.com>
References: <20060114155517.GA30543@wotan.suse.de>
 <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com>
 <20060114181949.GA27382@wotan.suse.de> <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
 <43C9DD98.5000506@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2006, Nick Piggin wrote:

> OK (either way is fine), but you should still drop the __isolate_lru_page
> nonsense and revert it like my patch does.

Ok with me. Magnus: You needed the __isolate_lru_page for some other 
purpose. Is that still the case?
