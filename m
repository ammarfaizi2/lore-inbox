Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVKNVsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVKNVsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVKNVsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:48:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17586 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751114AbVKNVsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:48:23 -0500
Date: Mon, 14 Nov 2005 13:48:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/5] atomic: atomic_inc_not_zero
Message-Id: <20051114134841.083ea51c.akpm@osdl.org>
In-Reply-To: <20051114082956.609ff5cd.pj@sgi.com>
References: <436416AD.3050709@yahoo.com.au>
	<4364171C.7020103@yahoo.com.au>
	<43641755.5010004@yahoo.com.au>
	<4364178E.8040502@yahoo.com.au>
	<20051114082956.609ff5cd.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>     +static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
>     +/* Atomic operations are already serializing */
>      void atomic_set(atomic_t *v, int i)
>      {
> 	    unsigned long flags;
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> 
> Whatever is the meaning of that "static inline ..."

copy-n-paste error, I expect.  Please send patch.
