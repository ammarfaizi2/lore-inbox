Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275347AbTHSE6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 00:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275335AbTHSE6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 00:58:53 -0400
Received: from fep02-svc.mail.telepac.pt ([194.65.5.201]:50374 "EHLO
	fep02-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S275347AbTHSE6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 00:58:52 -0400
Message-ID: <3F41AE34.1060600@vgertech.com>
Date: Tue, 19 Aug 2003 05:57:24 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: "Anthony R." <russo.lutions@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: cache limit
References: <3F41AA15.1020802@verizon.net>
In-Reply-To: <3F41AA15.1020802@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Anthony R. wrote:

[..snip..]

> With 2GB on a system, I should never page out, but I consistently do and I

One, very easy, solution is to do:
# swapoff -a

FWIW, I'd like an option to limit the cache size to a maximum amount... 
Say: echo 500000 > /proc/sys/vm/max_disk_cache

But, AFAIK, that's not going to happen.

Regards,
Nuno Silva


