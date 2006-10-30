Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965485AbWJ3Jau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965485AbWJ3Jau (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965488AbWJ3Jau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:30:50 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:56040 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S965485AbWJ3Jat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:30:49 -0500
Subject: Re: [PATCH 2/2] lockdep: annotate bcsp driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Jiri Kosina <jikos@jikos.cz>, David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1162199192.24143.172.camel@taijtu>
References: <1162199005.24143.169.camel@taijtu>
	 <1162199192.24143.172.camel@taijtu>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 10:30:08 +0100
Message-Id: <1162200608.24333.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.18-1.2699.fc6 #1
> ---------------------------------------------
> swapper/0 is trying to acquire lock:
>  (&list->lock#3){+...}, at: [<c05ad307>] skb_dequeue+0x12/0x43
> 
> but task is already holding lock:
>  (&list->lock#3){+...}, at: [<df98cd79>] bcsp_dequeue+0x6a/0x11e [hci_uart]
> 
> 
> Two different list locks nest, annotate so.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


