Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVAVAjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVAVAjd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbVAVAjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:39:13 -0500
Received: from ozlabs.org ([203.10.76.45]:11498 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262631AbVAVAfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:35:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16881.40893.35593.458777@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 11:35:09 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: "David S. Miller" <davem@davemloft.net>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Extend clear_page by an order parameter
In-Reply-To: <Pine.LNX.4.58.0501211545080.27045@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
	<Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
	<20050108135636.6796419a.davem@davemloft.net>
	<Pine.LNX.4.58.0501211210220.25925@schroedinger.engr.sgi.com>
	<16881.33367.660452.55933@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0501211545080.27045@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:

> clear_page clears one page of the specified order.

Now you're really being confusing.  A cluster of 2^n contiguous pages
isn't one page by any normal definition.  Call it "clear_page_cluster"
or "clear_page_order" or something, but not "clear_page".

Paul.
