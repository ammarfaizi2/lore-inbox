Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273068AbTG3RYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273078AbTG3RX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:23:59 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:5521 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S273068AbTG3RX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:23:58 -0400
Date: Wed, 30 Jul 2003 13:23:55 -0400
From: Yaroslav Halchenko <yoh@onerussian.com>
To: Sander van Malssen <svm@kozmix.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-bk3 phantom I/O errors
Message-ID: <20030730172355.GA19688@washoe.rutgers.edu>
References: <20030729153114.GA30071@washoe.rutgers.edu> <20030729135025.335de3a0.akpm@osdl.org> <20030730170432.GA692@kozmix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730170432.GA692@kozmix.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And I was running patched kernel for a day so far - no errors were
reported, so problem is really unpredictable. Probably the files which
were causing this problem before moved on a harddrive since then so I
can't reproduce the error. Hope it gives any hint

--Yarik

On Wed, Jul 30, 2003 at 07:04:32PM +0200, Sander van Malssen wrote:

> 
> Buffer I/O error on device hda1, logical block 25361
> Call Trace:
>  [<c0150f02>] buffer_io_error+0x42/0x50
>  [<c013b87d>] cache_grow+0x15d/0x260
>  [<c0151601>] end_buffer_async_read+0xf1/0x110
>  [<c0154330>] end_bio_bh_io_sync+0x30/0x40
>  [<c015548e>] bio_endio+0x4e/0x80
                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
