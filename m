Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTLTTw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 14:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTLTTw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 14:52:57 -0500
Received: from peabody.ximian.com ([141.154.95.10]:49344 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261298AbTLTTww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 14:52:52 -0500
Subject: Re: [PATCH 1/5] 2.6.0 fix preempt ctx switch accounting
From: Rob Love <rml@ximian.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031220192238.GA30970@elte.hu>
References: <3FE46885.2030905@cyberone.com.au>
	 <20031220192238.GA30970@elte.hu>
Content-Type: text/plain
Message-Id: <1071949972.3533.0.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sat, 20 Dec 2003 14:52:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-20 at 14:22, Ingo Molnar wrote:

> i'd prefer the much simpler patch below. This also keeps the kernel
> preemption logic isolated instead of mixing it into the normal path.

Much agreed, on both counts.

	Rob Love


