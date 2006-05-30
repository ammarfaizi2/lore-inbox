Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWE3BiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWE3BiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWE3BaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:30:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36544 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751553AbWE3B34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:29:56 -0400
Date: Mon, 29 May 2006 18:34:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 17/61] lock validator: sk_callback_lock workaround
Message-Id: <20060529183409.32b8896b.akpm@osdl.org>
In-Reply-To: <20060529212427.GQ3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212427.GQ3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:24:27 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> temporary workaround for the lock validator: make all uses of
> sk_callback_lock softirq-safe. (The real solution will be to
> express to the lock validator that sk_callback_lock rules are
> to be generated per-address-family.)

Ditto.  What's the actual problem being worked around here, and how's the
real fix shaping up?


