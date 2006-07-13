Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWGMUtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWGMUtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWGMUtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:49:51 -0400
Received: from [83.101.155.109] ([83.101.155.109]:26630 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1030380AbWGMUtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:49:50 -0400
From: Al Boldi <a1426z@gawab.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCHSET] 0/15 IO scheduler improvements
Date: Thu, 13 Jul 2006 23:50:47 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607132350.47388.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>
> This is a continuation of the patches posted yesterday, I continued
> to build on them. The patch series does:
>
> - Move the hash backmerging into the elevator core.
> - Move the rbtree handling into the elevator core.
> - Abstract the FIFO handling into the elevator core.
> - Kill the io scheduler private requests, that require allocation/free
>   for each request passed through the system.
>
> The result is a faster elevator core (and faster IO schedulers), with a
> nice net reduction of kernel text and code as well.

Thanks!

Your efforts are much appreciated, as the current situation is a bit awkward.

> If you have time, please give this patch series a test spin just to
> verify that everything still works for you. Thanks!

Do you have a combo-patch against 2.6.17?

Thanks!

--
Al

