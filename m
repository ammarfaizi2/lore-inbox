Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUHVMch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUHVMch (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 08:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266737AbUHVMch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 08:32:37 -0400
Received: from holomorphy.com ([207.189.100.168]:9860 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266733AbUHVMcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 08:32:33 -0400
Date: Sun, 22 Aug 2004 05:32:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fix PID hash sizing
Message-ID: <20040822123224.GC1510@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <412824BE.4040801@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412824BE.4040801@yahoo.com.au>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 02:44:46PM +1000, Nick Piggin wrote:
> I see PID hash sizing problems on an Opteron.
> I thought this got fixed a while ago? Hm.
> Export nr_kernel_pages, nr_all_pages. Use nr_kernel_pages when sizing
> the PID hash. This fixes a sizing problem I'm seeing with the x86-64 kernel
> on an Opteron.

Please describe the the pid hash sizing problem.


-- wli
