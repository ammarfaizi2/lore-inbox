Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262956AbSJGKAI>; Mon, 7 Oct 2002 06:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262962AbSJGKAI>; Mon, 7 Oct 2002 06:00:08 -0400
Received: from are.twiddle.net ([64.81.246.98]:28073 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262956AbSJGKAH>;
	Mon, 7 Oct 2002 06:00:07 -0400
Date: Mon, 7 Oct 2002 03:05:41 -0700
From: Richard Henderson <rth@twiddle.net>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
Message-ID: <20021007030541.A3910@twiddle.net>
Mail-Followup-To: Jakub Jelinek <jakub@redhat.com>, Andi Kleen <ak@muc.de>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20020929152731.GA10631@averell> <20020929160113.K5659@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020929160113.K5659@devserv.devel.redhat.com>; from jakub@redhat.com on Sun, Sep 29, 2002 at 04:01:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 04:01:13PM -0400, Jakub Jelinek wrote:
> Does this matter when the kernel is compiled with -fno-strict-aliasing?

Yes.  The malloc attribute uses REG_NOALIAS, not alias sets.


r~
