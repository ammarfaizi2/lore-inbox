Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbTJQR7p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTJQR7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:59:45 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:49105 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263581AbTJQR7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:59:44 -0400
Message-ID: <3F902E0A.5060908@colorfullife.com>
Date: Fri, 17 Oct 2003 19:59:38 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide write barrier support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens wrote:

>The problem is that as far as I can see the best way to make fsync
>really work is to make the last write a barrier write. That
>automagically gets everything right for you - when the last block goes
>to disk, you know the previous ones have already. And when the last
>block completes, you know the whole lot is on platter.
>
Are you sure?
What prevents the io scheduler from writing the last block before other 
blocks?

--
    Manfred

