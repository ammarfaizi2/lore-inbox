Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTIPOmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTIPOmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:42:31 -0400
Received: from dyn-ctb-210-9-243-132.webone.com.au ([210.9.243.132]:20742 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261923AbTIPOma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:42:30 -0400
Message-ID: <3F672095.60902@cyberone.com.au>
Date: Wed, 17 Sep 2003 00:39:17 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ludovico Gardenghi <dunadan@despammed.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Badness in as_completed_request in 2.6.0-test5-bk3
References: <20030915151231.GA9068@ripieno.somiere.org>
In-Reply-To: <20030915151231.GA9068@ripieno.somiere.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ludovico Gardenghi wrote:

>[I hope this message doesn't appear 2 times]
>
>Hello.
>
>I've read about this error and that it should have been patched in
>2.6.0-test5-bk3.
>
>I tried it because I got a lot of them with 2.6.0-test5 while removing
>lots of files (i.e. while starting sn at boot time), but I got the same error
>messages with 2.6.0-test5-bk3; moreover, i had also some "attempt to
>access beyond end of device" errors while trying to read a file from the
>same partition. Here are the messages:
>

Hi Ludovico,
Thanks for the report. The warnings themselves are harmless. As long
as you aren't seeing the processes hanging on IO.

Try disabling TCQ, I don't think it is very stable for IDE drives.


