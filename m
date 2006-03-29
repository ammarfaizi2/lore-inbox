Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWC2CXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWC2CXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 21:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWC2CXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 21:23:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28068 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750781AbWC2CXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 21:23:31 -0500
Date: Tue, 28 Mar 2006 18:23:24 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Zoltan Menyhart <Zoltan.Menyhart@free.fr>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
In-Reply-To: <4429CFCA.7010201@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0603281822570.18374@schroedinger.engr.sgi.com>
References: <200603281853.k2SIrGg28290@unix-os.sc.intel.com> <4429ADBC.50507@free.fr>
 <Pine.LNX.4.64.0603281537500.15037@schroedinger.engr.sgi.com>
 <4429CFCA.7010201@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2006, Nick Piggin wrote:

> However, I think it might be reaonsable to use bit lock operations for
> in places like page lock and buffer lock (ie. with acquire and relese
> semantics). It improves ia64 without harming other architectures, and
> also makes the code more expressive.

How would be express the acquire and release semantics?
