Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129866AbQLKFkT>; Mon, 11 Dec 2000 00:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129867AbQLKFkJ>; Mon, 11 Dec 2000 00:40:09 -0500
Received: from zero.tech9.net ([209.61.188.187]:4 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S129866AbQLKFjy>;
	Mon, 11 Dec 2000 00:39:54 -0500
Date: Mon, 11 Dec 2000 00:11:30 -0500 (EST)
From: "Robert M. Love" <rml@tech9.net>
To: <stewart@neuron.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kapm-idled : is this a bug?
In-Reply-To: <Pine.LNX.4.10.10012111151470.2070-100000@localhost>
Message-ID: <Pine.LNX.4.30.0012110009080.2487-100000@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000 stewart@neuron.com hissed:
>  I've recently begun testing my laptop on the latest 2.4.0-test12-pre[78]
>  kernels. When freshly booted and nothing producing a load on the system,
>  top reports a process called 'kapm-idled' consuming between 60% an 85%
>  of CPU cycles. [...]

its supposed to do this - its taking up the idle thread. its not actually
using those cpu cycles, dont worry.

yes, i agree -- its cpu usage shouldnt be shown as normal but integrated
under the idle thread.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
