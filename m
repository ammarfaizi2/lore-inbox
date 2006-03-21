Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWCULY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWCULY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWCULYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:24:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030296AbWCULYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:24:25 -0500
Date: Tue, 21 Mar 2006 03:21:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: optimize constant-size kzalloc calls
Message-Id: <20060321032101.3a4014fe.akpm@osdl.org>
In-Reply-To: <1142868958.11159.0.camel@localhost>
References: <1142868958.11159.0.camel@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> As suggested by Eric Dumazet, this patch optimizes kzalloc() calls
>  that pass a compile-time constant size.

Logical.

> Please note that the patch
>  increases kernel text slightly (~200 bytes for defconfig on x86)

Why?
