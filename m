Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262587AbTDBH50>; Wed, 2 Apr 2003 02:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262845AbTDBH50>; Wed, 2 Apr 2003 02:57:26 -0500
Received: from dial-ctb05128.webone.com.au ([210.9.245.128]:49162 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S262587AbTDBH5Z>;
	Wed, 2 Apr 2003 02:57:25 -0500
Message-ID: <3E8A9A83.1070704@cyberone.com.au>
Date: Wed, 02 Apr 2003 18:08:35 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.66-mm2 with contest
References: <200304021324.10799.kernel@kolivas.org> <3E8A6227.7080209@cyberone.com.au> <20030402074227.GH901@suse.de> <3E8A97D6.3000603@cyberone.com.au> <20030402075822.GB2925@suse.de>
In-Reply-To: <20030402075822.GB2925@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Wed, Apr 02 2003, Nick Piggin wrote:
>
>>Thanks for doing that, Jens. Any CPU measurements on the hash
>>goodness that you did for deadline?
>>
>
>Nope none yet, in fact Andrew's profile numbers show very little time
>spent inside the io scheduler hash as it is. It feels like the right
>thing to do though, even if the hash doesn't eat that much time.
>
I agree - especially as we want a smaller hash and with
more requests.

