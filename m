Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTLYGPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 01:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTLYGPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 01:15:55 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:24027 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263653AbTLYGPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 01:15:54 -0500
Message-ID: <3FEA8098.3000004@namesys.com>
Date: Thu, 25 Dec 2003 09:15:52 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
CC: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
Subject: Re: 2.6.0-test11 data loss
References: <3FEA0C3C.9090601@cs.oswego.edu> <20031224222217.GA3408@mfa.kfki.hu> <200312250934.17913.kernel@kolivas.org> <20031225020738.GA24690@bounceswoosh.org>
In-Reply-To: <20031225020738.GA24690@bounceswoosh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama wrote:

>
>
>
> It seems to me that the problem occurred at a higher system level than
> the disk, and disabling the write cache on the drive (besides being a
> *HUGE* performance loser) will only make the window for failure
> smaller, not eliminate it entirely.
>
You should only use write caching in kernels where write cache flushing 
is supported. Chris, which ones are those, could you remind us?

-- 
Hans


