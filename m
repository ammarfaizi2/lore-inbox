Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVF0TZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVF0TZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVF0TZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:25:41 -0400
Received: from graphe.net ([209.204.138.32]:53658 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261756AbVF0TWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:22:50 -0400
Date: Mon, 27 Jun 2005 12:22:45 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Badari Pulavarty'" <pbadari@us.ibm.com>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>, Lincoln Dale <ltd@cisco.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: RE: [rfc] lockless pagecache
In-Reply-To: <200506271905.j5RJ5ag22991@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0506271221540.21616@graphe.net>
References: <200506271905.j5RJ5ag22991@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005, Chen, Kenneth W wrote:

> I don't recall seeing tree_lock to be a problem for DSS workload either.

I have seen the tree_lock being a problem a number of times with large 
scale NUMA type workloads.

