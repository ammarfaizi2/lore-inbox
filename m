Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQKGIOk>; Tue, 7 Nov 2000 03:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129369AbQKGIOb>; Tue, 7 Nov 2000 03:14:31 -0500
Received: from mail.zmailer.org ([194.252.70.162]:38917 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129352AbQKGIOY>;
	Tue, 7 Nov 2000 03:14:24 -0500
Date: Tue, 7 Nov 2000 10:14:08 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andries Brouwer <aeb@veritas.com>, aprasad@in.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: processes> 2^15
Message-ID: <20001107101408.F13151@mea-ext.zmailer.org>
In-Reply-To: <CA25698D.00608C13.00@d73mta05.au.ibm.com> <20001104210158.A13496@veritas.com> <20001107085911.A2546@profile4u.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001107085911.A2546@profile4u.com>; from asl@launay.org on Tue, Nov 07, 2000 at 08:59:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 08:59:11AM +0100, Arnaud S . Launay wrote:
> In the fact, the first limit to be reached will be NR_TASKS defined in
> linux/tasks.h:
> #define NR_TASKS        512     /* On x86 Max 4092, or 4090 w/APM configured. */
> 
> So I wonder if we could really have more than 4092 process under x86 ?

   That define doesn't exist in 2.4 (anymore)

> 	Arnaud.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
