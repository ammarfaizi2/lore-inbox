Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTEVJ7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 05:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTEVJ7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 05:59:48 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:9354 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262742AbTEVJ7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 05:59:47 -0400
Date: Thu, 22 May 2003 03:15:38 -0700
From: Andrew Morton <akpm@digeo.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kiran@in.ibm.com, dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       davidm@hpl.hp.com
Subject: Re: [PATCH] per-cpu support inside modules (minimal)
Message-Id: <20030522031538.2cd124b8.akpm@digeo.com>
In-Reply-To: <20030522100511.751E02C0F1@lists.samba.org>
References: <20030522100511.751E02C0F1@lists.samba.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2003 10:12:51.0099 (UTC) FILETIME=[B3B26EB0:01C3204A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'll give this a run on the ppc64 tomorrow.

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> +static inline unsigned int abs(int val)
>  +{
>  +	if (val < 0)
>  +		return -val;
>  +	return val;
>  +}

Several architectures define their own abs() in asm/system.h which
return signed int.





