Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbUBWTCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 14:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUBWTCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 14:02:22 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:64527 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262001AbUBWTCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 14:02:18 -0500
Date: Mon, 23 Feb 2004 19:02:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Subject: Re: [PATCH] fix shmat
Message-ID: <20040223190207.B12585@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Manfred Spraul <manfred@colorfullife.com>, piggin@cyberone.com.au,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	torvalds@osdl.org
References: <E1AvBNO-0004QF-00@bkwatch.colorfullife.com> <403A4328.5010302@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <403A4328.5010302@colorfullife.com>; from manfred@colorfullife.com on Mon, Feb 23, 2004 at 07:15:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 07:15:04PM +0100, Manfred Spraul wrote:
> Why? sys_shmat is not a system call. Or at least there is a comment just 
> before the implementation that this is not a syscall.
> I think either the asmlinkage or the comment are wrong:

On 64bit mips kernels it's a syscall.  On parics, too but they use a
wrapper neverless.

