Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753924AbWKRFn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbWKRFn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932AbWKRFn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:43:59 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34180 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753924AbWKRFn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:43:58 -0500
Date: Fri, 17 Nov 2006 21:43:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Manfred Spraul <manfred@colorfullife.com>,
       Christoph Lameter <clameter@sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Message-Id: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 0/7] Remove slab cache declarations in slab.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the strange issues in include/linux/slab.h that it contains
a list of global slab caches. The following patches remove all the global
definitions from slab.h and find other ways of defining these caches.

6 of the 7 defined caches are rarely used. One is never used.
