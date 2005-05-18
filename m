Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVERBGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVERBGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 21:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVERBGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 21:06:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:20965 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262034AbVERBGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 21:06:16 -0400
Date: Tue, 17 May 2005 18:05:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tejun Heo <htejun@gmail.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.12-rc4] block: cfq request selection
 improvement
Message-Id: <20050517180527.139fe4d0.akpm@osdl.org>
In-Reply-To: <20050517141441.GA26769@htj.dyndns.org>
References: <20050517141441.GA26769@htj.dyndns.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:
>
>   Previously, each cfqq used separate sliding window (find_best_crq ==
>  1) or selected the first request (find_best_crq == 0).  This patch
>  implements global sliding window (find_bset_crq == 2) for request
>  selection from cfqq.

There's a great big revamp of the CFQ scheduler in -mm.  Perhaps you should
be testing and patching that?

