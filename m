Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263025AbVCXEkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbVCXEkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 23:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbVCXEkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 23:40:05 -0500
Received: from fire.osdl.org ([65.172.181.4]:64211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263025AbVCXEj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 23:39:59 -0500
Date: Wed, 23 Mar 2005 20:38:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: David McCullough <davidm@snapgear.com>
Cc: cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
Message-Id: <20050323203856.17d650ec.akpm@osdl.org>
In-Reply-To: <20050324042708.GA2806@beast>
References: <20050315133644.GA25903@beast>
	<20050324042708.GA2806@beast>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David McCullough <davidm@snapgear.com> wrote:
>
> Here is a small patch for 2.6.11 that adds a routine:
> 
>  	add_true_randomness(__u32 *buf, int nwords);

It neither applies correctly nor compiles in current kernels.  2.6.11 is
very old in kernel time.

Are we likely to see any in-kernel users of this?
