Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWAJUKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWAJUKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWAJUKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:10:41 -0500
Received: from ns2.suse.de ([195.135.220.15]:59037 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932309AbWAJUKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:10:41 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH 3 of 3] Add __raw_memcpy_toio32 to each arch
Date: Tue, 10 Jan 2006 21:08:59 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org,
       rdreier@cisco.com
References: <5673a186625f62491f33.1136922839@serpentine.internal.keyresearch.com>
In-Reply-To: <5673a186625f62491f33.1136922839@serpentine.internal.keyresearch.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601102109.00067.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 20:53, Bryan O'Sullivan wrote:
> Most arches use the generic routine.  x86_64 uses memcpy32 instead;
> this is substantially faster, even over a bus that is much slower than
> the CPU.

So did you run numbers against the C implementation with -funroll-loops ? 
What were the results?

-Andi
