Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWDXXz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWDXXz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 19:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWDXXz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 19:55:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932132AbWDXXz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 19:55:58 -0400
Date: Mon, 24 Apr 2006 16:58:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: Re: [patch 11/13] s390: instruction processing damage handling.
Message-Id: <20060424165823.0065c826.akpm@osdl.org>
In-Reply-To: <20060424150544.GL15613@skybase>
References: <20060424150544.GL15613@skybase>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> +			tmp = get_clock();

s390 has a get_clock()?  I guess you don't use i2c much.

We shouldn't use such generic-looking identifiers for arch-specific things.
 But I guess you can defer the great renaming to s390_get_clock() until
something actually breaks.

