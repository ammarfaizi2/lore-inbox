Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTKIGci (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 01:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTKIGci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 01:32:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54727 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262192AbTKIGch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 01:32:37 -0500
Date: Sat, 8 Nov 2003 22:26:45 -0800
From: "David S. Miller" <davem@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: steiner@sgi.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] - Incorrect cpumask definition in net/core/flow.c
Message-Id: <20031108222645.4e3d23f1.davem@redhat.com>
In-Reply-To: <E1AIJIT-0002q9-00@gondolin.me.apana.org.au>
References: <20031107210848.GA10774@sgi.com>
	<E1AIJIT-0002q9-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Nov 2003 13:57:57 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Here is a patch that changes the operations on the maps as well
> for consistency.

This is the correct patch, applied thanks.

I have another patch that cleans up this stuff in a better
albeit intrusive way from Rusty, but let's be safe for 2.6.0
