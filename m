Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTE0KCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 06:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbTE0KCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 06:02:00 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:4501 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263179AbTE0KB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 06:01:59 -0400
Date: Tue, 27 May 2003 03:15:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: Miles Bader <miles@gnu.org>
Cc: miles@lsi.nec.co.jp, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v850]  Define flush_page_to_ram on v850/nb85e
Message-Id: <20030527031514.34be520d.akpm@digeo.com>
In-Reply-To: <20030527092133.2B7A0375B@mcspd15.ucom.lsi.nec.co.jp>
References: <20030527092133.2B7A0375B@mcspd15.ucom.lsi.nec.co.jp>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 10:15:13.0123 (UTC) FILETIME=[DC6A5330:01C32438]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

miles@lsi.nec.co.jp (Miles Bader) wrote:
>
> +#define flush_page_to_ram(x)	((void)0)

flush_page_to_ram() has been removed from the kernel, so we no longer
need this patch.


