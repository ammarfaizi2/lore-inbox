Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbWEKGP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbWEKGP3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 02:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbWEKGP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 02:15:29 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:62115 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965142AbWEKGP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 02:15:28 -0400
Date: Thu, 11 May 2006 09:15:23 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add slab_is_available() routine for boot code
In-Reply-To: <20060510205543.GI3198@w-mikek2.ibm.com>
Message-ID: <Pine.LNX.4.58.0605110914510.31749@sbz-30.cs.Helsinki.FI>
References: <20060510205543.GI3198@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006, Mike Kravetz wrote:
> +/*
> + * used by boot code to determine if it can use slab based allocator
> + */
> +int slab_is_available(void)
> +{
> +	return g_cpucache_up == FULL;
> +}
> +

Please use proper kerneldoc format so you don't create extra work for 
janitors.

				Pekka
