Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWERFoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWERFoY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWERFoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:44:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56272 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751214AbWERFoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:44:23 -0400
Date: Wed, 17 May 2006 22:43:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: artusemrys@sbcglobal.net
Cc: vgoyal@in.ibm.com, galak@kernel.crashing.org, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [RFC][PATCH 1/6] kconfigurable resources core changes
Message-Id: <20060517224334.7d2bb5eb.akpm@osdl.org>
In-Reply-To: <446C03F4.20508@sbcglobal.net>
References: <20060505172847.GC6450@in.ibm.com>
	<2C184B1B-9F70-4175-B90B-A1CC5741A6DE@kernel.crashing.org>
	<20060509200301.GA15891@in.ibm.com>
	<446C03F4.20508@sbcglobal.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Frost <artusemrys@sbcglobal.net> wrote:
>
> This may sound like a dumb question, but aside from code bloat, what are 
>  the performance issues involved in running 64-bit resources on 32-bit 
>  systems?

Unmeasurably minor, I expect.

No sane software project would take on this (small) maintenance burden just
to save 50-60 kbytes.  We would though.
