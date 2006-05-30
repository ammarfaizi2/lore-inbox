Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWE3Bbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWE3Bbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWE3Bbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:31:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3521 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932107AbWE3Bbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:31:34 -0400
Date: Mon, 29 May 2006 18:35:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 46/61] lock validator: special locking: slab
Message-Id: <20060529183549.97a90e12.akpm@osdl.org>
In-Reply-To: <20060529212649.GT3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212649.GT3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:26:49 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> +		/*
> +		 * Do not assume that spinlocks can be initialized via memcpy:
> +		 */

I'd view that as something which should be fixed in mainline.
